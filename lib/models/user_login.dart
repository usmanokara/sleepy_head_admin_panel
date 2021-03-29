import 'package:parse_server_sdk/parse_server_sdk.dart';

class UserLogin {
  ParseUser _parseUser;

  void userLoad() async {
    ParseUser currentUser = await ParseUser
        .currentUser(); //The current user was save in the phone with SharedPrefferences
    if (currentUser == null) {
      return null;
    } else {
      _parseUser = currentUser;
      print("AUTO LOGIN SUCCESS");
      var result = currentUser.login();
      result.catchError((e) {
        print(e);
      });
    }
  }

  Future<ParseUser> login(username, pass, email) async {
    var user = ParseUser(username, pass, email);
    var response = await user.login();
    if (response.success) {
      _parseUser = user; //Keep the user
      print(user.objectId);
    } else {
      print(response.error.message);
    }

    return _parseUser;
  }

  Future<ParseUser> signUP(username, pass, email) async {
    var user = ParseUser(username, pass,
        email); //You can add Collumns to user object adding "..set(key,value)"
    var result = await user.create();
    if (result.success) {
      _parseUser = user; //Keep the user
      print(user.objectId);
    } else {
      print(result.error.message);
    }
    return _parseUser;
  }
}
