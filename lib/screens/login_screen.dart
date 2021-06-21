import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sleepy_head_panel/screens/home_screen.dart';
import 'package:sleepy_head_panel/utils/progressBar.dart';
import 'package:sleepy_head_panel/values/colors.dart';
import 'package:sleepy_head_panel/values/references.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'LoginPage';
  LoginScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  ParseUser parseUser;
  String douserName = 'admin';
  String dopassword = '';
  String doemail = '';

  //Login
  Future<ParseUser> loginWithEmailPassword(username, pass, email) async {
    print(username);
    print(email);
    print(pass);
    var user =
        ParseUser(username.toString(), pass.toString(), email.toString());
    var response = await user.login();
    if (response.success) {
      setState(() {
        parseUser = user; //Keep the user
      });
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.id, (route) => false);
      print(user.objectId);
    } else {
      print(response.error.message);
      showSuccess('Error!', response.error.message);
    }
  }

  // Future<void> doUserRegistration(
  //     String username, String password, String email) async {
  //   final user = ParseUser.createUser(username, password, email);
  //   var response = await user.signUp();
  //   if (response.success) {
  //     print('Sign Up successful: ${response.success}');
  //     // await user.verificationEmailRequest();
  //     // showSuccess('Success!',
  //     //     'User was successfully created!\nPlease verify your email.');
  //   } else {
  //     print(response.error.message);
  //     // showSuccess('Error!', response.error.message);
  //   }
  // }

  void showSuccess(String title, String detail) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "$title",
            style: TextStyle(),
          ),
          content: Text(
            "$detail",
            style: TextStyle(),
          ),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      onChanged: (value) {
        doemail = value;
      },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      onChanged: (value) {
        dopassword = value;
      },
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(colors: [
            MyGradientColors.onBoardingGradientColorLeft,
            MyGradientColors.onBoardingGradientColorRight,
          ])),
      height: 48,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () async {
          // await loginWithEmailPassword(
          //     douserName.toString(), dopassword.toString(), doemail.toString());

          Navigator.of(context).push(PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) =>
                  AndroidProgressModel()));
          Future.delayed(Duration(seconds: 1));

          if (doemail.isEmpty || doemail == null) {
            showSuccess('Sleepy Head', 'Email cannot be null or empty');
            return;
          }
          if (isEmail(doemail) == false) {
            showSuccess('Sleepy Head', 'Invalid email');
            return;
          }
          if (dopassword.isEmpty || dopassword == null) {
            showSuccess('Sleepy Head', 'Password cannot be null or empty');

            return;
          }

          doemail == 'calmingaudio@gmail.com' && dopassword == 'c@l@iming@udio'
              ? Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.id, (route) => false)
              : showSuccess(
                  'Sleepy Head',
                  doemail == 'calmingaudio@gmail.com'
                      ? 'Wrong password'
                      : 'Wrong email');
        },
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: MyColors.whiteTextColor,
                fontSize: 16,
                fontFamily: MyReferences.SFPro),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    MyGradientColors.splashGradientColor1,
                    MyGradientColors.splashGradientColor2
                  ]),
            ),
            height: double.infinity,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: 500, minWidth: 150, maxHeight: 500, minHeight: 400),
              child: Card(
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.all(42),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        Center(
                          child: Image.asset(
                            'images/splashlogo.png',
                            width: 60,
                            height: 60,
                          ),
                        ),
                        Text('Sleepy Head'),
                        SizedBox(height: 48.0),
                        email,
                        SizedBox(height: 8.0),
                        password,
                        SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value;
                                    });
                                  },
                                ),
                                Text("Remember Me")
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        loginButton,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
