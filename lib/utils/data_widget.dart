import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sleepy_head_panel/constants/static_data.dart';
import 'package:sleepy_head_panel/values/colors.dart';

import 'editFileDialog.dart';

class DataWidget extends StatefulWidget {
  const DataWidget({this.title, this.keys});
  final String title;
  final keys;

  @override
  _DataWidgetState createState() => _DataWidgetState();
}

class _DataWidgetState extends State<DataWidget> {
  List<bool> selectedValue = [];
  List<String> checkList = [];
  bool isAllSelect = false;

  @override
  void initState() {
    // TODO: implement initState
    if (mounted)
      Future.delayed(
          Duration(seconds: 1), () => {if (mounted) setState(() {})});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        child: Icon(
                          Icons.perm_identity_outlined,
                          color: Colors.transparent,
                        ),
                      ),
                      Text("${widget.title}"),
                      Container(
                        width: 40,
                        height: 70,
                        child: MaterialButton(
                          onPressed: () {
                            if (mounted)
                              setState(() {
                                StaticData.logoutPanel =
                                    !StaticData.logoutPanel;
                              });
                          },
                          child: Icon(
                            Icons.perm_identity_outlined,
                            color: MyColors.bottomBarColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 5,
              ),
              height: 75,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          selectedValue.contains(true)
                              ? MaterialButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    // showAlertDialog(context,StaticData.apiData[index]);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 19,
                                      ),
                                      Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(width: 5),
                          MaterialButton(
                            color: MyGradientColors.onBoardingGradientColorLeft,
                            onPressed: () async {
                              await showAddDialog(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 19,
                                ),
                                Text(
                                  'Add',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
                        thickness: 0.5,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MediaQuery.of(context).size.width > 900
                              ? Checkbox(
                                  value: isAllSelect,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isAllSelect = !isAllSelect;
                                    });
                                    for (int i = 0;
                                        i < selectedValue.length;
                                        i++) selectedValue[i] = isAllSelect;
                                  },
                                )
                              : Visibility(visible: false, child: Text('')),
                          Expanded(
                              child: Text(
                            'ID',
                            maxLines: 1,
                          )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Expanded(
                              child: Text(
                            'Name',
                            maxLines: 1,
                          )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Expanded(
                            child: Text(
                              'Song Category',
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Expanded(
                            child: Text(
                              'File',
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Expanded(
                            child: Text(
                              'Duration',
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Text(
                            'Edit',
                            maxLines: 1,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Text(
                            'Delete',
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Divider(
                        color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
                        thickness: 1,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: StaticData.apiData.length,
                          itemBuilder: (BuildContext context, int index) {
                            selectedValue.add(false);
                            return StaticData.apiData.isNotEmpty
                                ? Column(
                                    children: [
                                      InkWell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            MediaQuery.of(context).size.width >
                                                    900
                                                ? Checkbox(
                                                    value: selectedValue[index],
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        selectedValue[index] =
                                                            !selectedValue[
                                                                index];
                                                        isAllSelect = false;
                                                      });
                                                      print(
                                                          'Current selected Item: $index');
                                                    },
                                                  )
                                                : Visibility(
                                                    visible: false,
                                                    child: Text('')),
                                            Expanded(
                                                child: Text(
                                              StaticData
                                                  .apiData[index].objectId,
                                              maxLines: 1,
                                            )),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            Expanded(
                                                child: Text(
                                              StaticData
                                                  .apiData[index].songName,
                                              maxLines: 1,
                                            )),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            Expanded(
                                              child: Text(
                                                StaticData.apiData[index]
                                                    .songCategory,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            Expanded(
                                              child: Text(
                                                StaticData
                                                    .apiData[index].songName,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            Expanded(
                                              child: Text(
                                                StaticData
                                                    .apiData[index].duration,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            InkWell(
                                              onTap: () async {
                                                await showEditDialog(context,
                                                    StaticData.apiData[index]);
                                                print(
                                                    ' selected Item for edit: $index');
                                              },
                                              child: Icon(
                                                Icons.edit,
                                                color: MyGradientColors
                                                    .onBoardingGradientColorLeft,
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            InkWell(
                                              onTap: () async {
                                                await showAlertDialog(context,
                                                    StaticData.apiData[index]);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          //
                                          print(
                                              'Current selected Item: $index');
                                        },
                                      ),
                                      Divider(
                                        color: MyColors.ScreenBackgroundColor
                                            .withOpacity(0.4),
                                        thickness: 0.5,
                                      ),
                                    ],
                                  )
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    // StaticData.audioPlayer = new AssetsAudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        child: Icon(
                          Icons.perm_identity_outlined,
                          color: Colors.transparent,
                        ),
                      ),
                      Text("Home"),
                      Container(
                        width: 40,
                        height: 70,
                        child: MaterialButton(
                          onPressed: () {
                            //
                            if (mounted)
                              setState(() {
                                StaticData.logoutPanel =
                                    !StaticData.logoutPanel;
                              });
                          },
                          child: Icon(
                            Icons.perm_identity_outlined,
                            color: MyColors.bottomBarColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 5,
              ),
              height: 75,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 200, maxHeight: 200),
                            height: MediaQuery.of(context).size.width / 5,
                            width: MediaQuery.of(context).size.width / 5,
                            child: Image.asset('images/splashlogo.png'),
                          ),
                          Text(
                            'Sleepy head',
                            style: TextStyle(
                                fontSize: 24,
                                color: MyGradientColors.splashGradientColor1),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(
                            'Play unlimited music',
                            maxLines: 1,
                          )),
                        ],
                      ),
                      Divider(
                        color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
                        thickness: 1,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: StaticData.apiData.length,
                          itemBuilder: (BuildContext context, int index) {
                            return StaticData.apiData.isNotEmpty
                                ? Column(
                                    children: [
                                      InkWell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                              StaticData
                                                  .apiData[index].songName,
                                              maxLines: 1,
                                            )),
                                            SizedBox(width: 30),
                                            Expanded(
                                              child: Text(
                                                StaticData.apiData[index]
                                                    .songCategory,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Expanded(
                                              child: Text(
                                                StaticData
                                                    .apiData[index].duration,
                                                maxLines: 1,
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            InkWell(
                                              onTap: () async {
                                                //
                                                // print(index);
                                                // await StaticData.audioPlayer
                                                //     .stop();
                                                // StaticData.audioPlayer
                                                //     .dispose();
                                                // StaticData.audioPlayer =
                                                //     new AssetsAudioPlayer();
                                                // await StaticData.audioPlayer
                                                //     .open(Audio.network(
                                                //         StaticData
                                                //                 .apiData[index]
                                                //                 .musicFiles[
                                                //             'url']));
                                                // setState(() {
                                                //   StaticData.state =
                                                //       PlayerState.play;
                                                // });
                                              },
                                              child: Icon(
                                                Icons.play_circle_outline_sharp,
                                                color: MyGradientColors
                                                    .splashGradientColor1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          //
                                          // StaticData.audioPlayer.play(StaticData
                                          //     .apiData[index]
                                          //     .musicFiles['url']);

                                          print(
                                              'Current selected Item: $index');
                                        },
                                      ),
                                      Divider(
                                        color: MyColors.ScreenBackgroundColor
                                            .withOpacity(0.4),
                                        thickness: 0.5,
                                      ),
                                    ],
                                  )
                                : CircularProgressIndicator();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
