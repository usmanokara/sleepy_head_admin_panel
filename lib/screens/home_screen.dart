import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sleepy_head_panel/constants/static_data.dart';
import 'package:sleepy_head_panel/services/get_data.dart';
import 'package:sleepy_head_panel/utils/data_widget.dart';
import '../utils/editFileDialog.dart';
import 'package:sleepy_head_panel/values/colors.dart';

bool isEditVisible = false;
int currentPlayIndex = 0;
bool isDrawer = true;

class HomeScreen extends StatefulWidget {
  static const String id = 'homeScreen';
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int active = 0;
  @override
  void initState() {
    initData();
    super.initState();
    tabController = new TabController(vsync: this, length: 3, initialIndex: 0)
      ..addListener(() {
        if (mounted)
          setState(() {
            active = tabController.index;
          });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Row(
            children: <Widget>[
              MediaQuery.of(context).size.width < 900
                  ? Container()
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: 250,
                      child: Card(
                        elevation: 15,
                        child: listDrawerItems(false),
                      ),
                    ),
              Container(
                width: MediaQuery.of(context).size.width < 900
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width - 310,
                child: Center(
                  child: Stack(children: [
                    TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        HomeWidget(),
                        DataWidget(
                          title: 'Music',
                        ),
                        CategoryGridView(),
                        // Dashboard(),
                        // FormMaterial(),
                        // HeroAnimation(),
                      ],
                    ),
                    // StaticData.state == PlayerState.play
                    //     ? Positioned(
                    //         bottom: 0.1,
                    //         left: 0.1,
                    //         right: 0.1,
                    //         child: Container(
                    //           child: Card(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Text(''),
                    //                     Expanded(
                    //                       child: Padding(
                    //                         padding: const EdgeInsets.symmetric(
                    //                             horizontal: 30),
                    //                         child: Slider(
                    //                             min: 0,
                    //                             max: 50,
                    //                             value: 4,
                    //                             onChanged: (value) {
                    //                               //
                    //                             }),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   children: [
                    //                     Icon(
                    //                       Icons.play_circle_filled_outlined,
                    //                       color: MyGradientColors
                    //                           .onBoardingGradientColorLeft,
                    //                       size: 50,
                    //                     )
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //             elevation: 0,
                    //           ),
                    //         ))
                    //     : Container(),
                  ]),
                ),
              )
            ],
          ),
          Visibility(
            visible: isDrawer,
            child: Positioned(
              top: 30,
              left: 20,
              child: Container(
                width: 40,
                child: MaterialButton(
                  color: MyGradientColors.onBoardingGradientColorLeft,
                  onPressed: () {
                    //
                    _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: MyColors.whiteTextColor,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: StaticData.logoutPanel,
            child: Positioned(
              top: 60,
              right: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    //
                  },
                  //,
                  child: Card(
                    elevation: 4,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                            SizedBox(width: 8),
                            Text('Logout'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        elevation: 10,
        child: listDrawerItems(true),
      ),
    );
  }

  Widget listDrawerItems(bool drawerStatus) {
    if (mounted)
      setState(() {
        isDrawer = drawerStatus;
      });
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Admin App',
                style: TextStyle(color: MyColors.ScreenBackgroundColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Sleepy Head',
                style: TextStyle(
                    color: MyColors.ScreenBackgroundColor, fontSize: 24),
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Divider(
          color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
          thickness: 0.3,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contents',
                style: TextStyle(
                    color: MyColors.ScreenBackgroundColor, fontSize: 18),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            tabController.animateTo(0);
                            drawerStatus ? Navigator.pop(context) : print("");
                          },
                          child: Text(
                            'Home',
                            style: TextStyle(
                                color: tabController.index == 0
                                    ? MyGradientColors.splashGradientColor1
                                    : Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            tabController.animateTo(1);
                            drawerStatus ? Navigator.pop(context) : print("");
                          },
                          child: Text(
                            'Music',
                            style: TextStyle(
                                color: tabController.index == 1
                                    ? MyGradientColors.splashGradientColor1
                                    : Colors.black,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        InkWell(
                          child: Text(
                            'Category',
                            style: TextStyle(
                                color: tabController.index == 2
                                    ? MyGradientColors.splashGradientColor1
                                    : Colors.black,
                                fontSize: 16),
                          ),
                          onTap: () {
                            tabController.animateTo(2);
                            drawerStatus ? Navigator.pop(context) : print("");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

void initData() async {
  await GetData().getTodoList();
  await GetData().getTodoList1();
  for (int i = 0; i < StaticData.categoryData.length; i++)
    StaticData.currencies.add(StaticData.categoryData[i].songCategory);
}

class CategoryGridView extends StatefulWidget {
  @override
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {
  List<bool> selectedValue = [];
  bool isAllSelect = false;
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
                      Text("Music Category"),
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
                              await showCategoryAddDialog(context).whenComplete(
                                  () => Navigator.of(context).pop());
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
                                    if (mounted)
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
                            'Id',
                            maxLines: 1,
                          )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width > 900
                                  ? 30
                                  : 5),
                          Expanded(
                              child: Text(
                            'Title',
                            maxLines: 1,
                          )),
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
                          itemCount: StaticData.categoryData.length,
                          itemBuilder: (BuildContext context, int index) {
                            selectedValue.add(false);
                            return StaticData.categoryData.isNotEmpty
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
                                                      if (mounted)
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
                                                  .categoryData[index].objectId,
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
                                              StaticData.categoryData[index]
                                                  .songCategory,
                                              maxLines: 1,
                                            )),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        900
                                                    ? 30
                                                    : 5),
                                            InkWell(
                                              onTap: () async {
                                                await showEditCategoryDialog(
                                                    context,
                                                    StaticData
                                                        .categoryData[index]);
                                                Navigator.of(context).pop();
                                                setState(() {});
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
                                                await showCategoryAlertDialog(
                                                    context,
                                                    StaticData
                                                        .categoryData[index]);
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
