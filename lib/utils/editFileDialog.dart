// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleepy_head_panel/models/category_model.dart';
import 'package:sleepy_head_panel/models/songs.dart';
import 'package:sleepy_head_panel/network_utils/song_utils.dart';
import 'package:sleepy_head_panel/utils/progressBar.dart';
import 'package:sleepy_head_panel/values/colors.dart';
import 'package:sleepy_head_panel/values/references.dart';

TextEditingController nameController = new TextEditingController();
TextEditingController categoryController = new TextEditingController();
TextEditingController durationController = new TextEditingController();
TextEditingController fileController = new TextEditingController();
PlatformFile audioFile;

// void uploadFile1() async {
//   print('Audio File: ${audioFile.name}');
//
//   uploadInput.click();
//   uploadInput.onChange.listen((e) {
//     // read file content as dataURL
//     final files = uploadInput.files;
//     final reader = new FileReader();
//
//     if (files != null) {
//       audioFile = files.first;
//       print('Audio File is: $audioFile');
//       fileController.text = audioFile.name;
//       reader.onLoad.listen((e) {
//         // sendFile(reader.result);
//         print(e);
//       });
//
//       reader.readAsDataUrl(audioFile);
//     }
//   });
// }

void uploadFile() async {
  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp3'],
  );

  if (result != null) {
    audioFile = result.files[0];
    print('Audio File is: $audioFile');
    fileController.text = audioFile.name;
  } else {
    // User canceled the picker

  }
}

showAlertDialog(BuildContext context, Songs model) {
  Widget cancelButton = MaterialButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Delete"),
    onPressed: () async {
      //
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      await SongsUtils.deleteTodo(model.objectId).whenComplete(() => {
            Navigator.of(context).pop(),
          });
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Sleepy Head"),
    content: Text("Would you like to delete selected Category?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showCategoryAlertDialog(BuildContext context, CategoryModel model) {
  print(model.songCategory);
  Widget cancelButton = MaterialButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Delete"),
    onPressed: () async {
      //
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      await SongsUtils.deleteCategory(model.objectId).whenComplete(() => {
            Navigator.of(context).pop(),
          });
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Sleepy Head"),
    content: Text("Would you like to delete selected records?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showEditDialog(BuildContext context, Songs model) {
  nameController.text = model.songName.toString();
  categoryController.text = model.songCategory.toString();
  fileController.text = model.musicFiles['name'].toString();
  durationController.text = model.duration.toString();

  Widget cancelButton = MaterialButton(
    color: MyGradientColors.onBoardingGradientColorLeft,
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Update"),
    color: MyGradientColors.onBoardingGradientColorLeft,
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      Songs updateSong = Songs(
        duration: durationController.text.toString(),
        songName: nameController.text.toString(),
        songCategory: categoryController.text.toString(),
        objectId: model.objectId,
        musicFiles: {
          '__type': 'File',
          'name': audioFile.name,
          'url': audioFile.bytes,
        },
      );
      SongsUtils.updateTodo(updateSong).whenComplete(() => {
            Navigator.of(context).pop(),
          });
      print('Audio File: ${audioFile.name}');
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Edit music object"),
    content: Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        controller: nameController,
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {},
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
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
              children: [
                Expanded(
                  child: Text(
                    'Song Category',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {},
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Select category',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
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
              children: [
                Expanded(
                  child: Text(
                    'File',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        controller: fileController,
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {},
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Choose file',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          suffix: InkWell(
                            onTap: () {
                              uploadFile();
                            },
                            child: Icon(
                              Icons.upload_file,
                              color: MyGradientColors.splashGradientColor1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Duration',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        controller: durationController,
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {},
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Enter Duration',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
              thickness: 0.5,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showEditCategoryDialog(BuildContext context, CategoryModel model) {
  TextEditingController categoryController = new TextEditingController();
  categoryController.text = model.songCategory.toString();
  Widget cancelButton = MaterialButton(
    color: MyGradientColors.onBoardingGradientColorLeft,
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Update"),
    color: MyGradientColors.onBoardingGradientColorLeft,
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      CategoryModel updateSong = CategoryModel(
        objectId: model.objectId,
        songCategory: categoryController.text.toString(),
      );
      SongsUtils.updateCategory(updateSong).whenComplete(() => {
            Navigator.of(context).pop(),
          });
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Edit music object"),
    content: Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        controller: categoryController,
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {},
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
              thickness: 0.5,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

String name = '';
String duration;
String category;
showAddDialog(BuildContext context) {
  Widget cancelButton = MaterialButton(
    color: MyGradientColors.onBoardingGradientColorLeft,
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Add"),
    color: MyGradientColors.onBoardingGradientColorLeft,
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      Songs addSong = Songs(
        duration: duration,
        songName: name.toString(),
        songCategory: category,
        musicFiles: {
          '__type': 'File',
          'name': audioFile.name,
          'url': audioFile.bytes,
        },
      );

      SongsUtils.addTodo(addSong).whenComplete(() => {
            Navigator.of(context).pop(),
          });
      print('Audio File: ${audioFile.name}');
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Add music"),
    content: Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Name',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {
                          name = text;
                        },
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
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
              children: [
                Expanded(
                  child: Text(
                    'Song Category',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {
                          category = text;
                        },
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Select category',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
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
              children: [
                Expanded(
                  child: Text(
                    'File',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 37,
                    child: Center(
                      child: TextField(
                        controller: fileController,
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (String text) {},
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Choose file',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          suffix: InkWell(
                            onTap: () {
                              uploadFile();
                            },
                            child: Icon(
                              Icons.upload_file,
                              color: MyGradientColors.splashGradientColor1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Duration',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {
                          duration = text;
                        },
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Enter Duration',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
              thickness: 0.5,
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showCategoryAddDialog(BuildContext context) {
  String addCategoryText = '';
  Widget cancelButton = MaterialButton(
    color: MyGradientColors.onBoardingGradientColorLeft,
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Add"),
    color: MyGradientColors.onBoardingGradientColorLeft,
    onPressed: () {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      CategoryModel addSong = CategoryModel(
        songCategory: addCategoryText.toString(),
      );

      SongsUtils.addToCategory(addSong)
          .whenComplete(() => {Navigator.of(context).pop()});
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Add Category"),
    content: Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Category',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: SizedBox(
                    height: 30,
                    child: Center(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        onChanged: (String text) {
                          addCategoryText = text;
                        },
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: MyReferences.SFPro),
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey.withOpacity(0.8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Divider(
              color: MyColors.ScreenBackgroundColor.withOpacity(0.4),
              thickness: 0.5,
            ),
          ],
        ),
      ),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return true;
}
