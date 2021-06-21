import 'dart:html' as html;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:sleepy_head_panel/models/category_model.dart';
import 'package:sleepy_head_panel/models/songs.dart';
import 'package:sleepy_head_panel/network_utils/song_utils.dart';
import 'package:sleepy_head_panel/utils/progressBar.dart';
import 'package:sleepy_head_panel/values/colors.dart';
import 'package:sleepy_head_panel/values/references.dart';
import '../constants/static_data.dart';
import 'package:flutter/material.dart';

TextEditingController nameController = new TextEditingController();
TextEditingController categoryController = new TextEditingController();
TextEditingController durationController = new TextEditingController();
TextEditingController fileController = new TextEditingController();
TextEditingController imageController = new TextEditingController();

// PlatformFile audioFile;

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
var values;
PlatformFile uploadedImage;
PlatformFile uploadedFile;

void uploadImage() async {
  // final completer = Completer<List<String>>();
  // InputElement uploadInput = FileUploadInputElement();
  // uploadInput.multiple = true;
  // uploadInput.accept = 'image/*';
  // uploadInput.click();
  // // onChange doesn't work on mobile safari
  // uploadInput.addEventListener('change', (e) async {
  //   // read file content as dataURL
  //   final files = uploadInput.files;
  //   print("files :${files.first.relativePath}");
  //   Iterable<Future<String>> resultsFutures = files.map((file) {
  //     print("files :${file.relativePath}");
  //
  //     final reader = FileReader();
  //     reader.readAsDataUrl(file);
  //     // reader.onError.listen((error) => completer.completeError(error));
  //     return reader.onLoad.first
  //         .then((value) => audioPath = value.path.toString());
  //   });
  //
  //   final results = await Future.wait(resultsFutures);
  //   completer.complete(results);
  // });
  // // need to append on mobile safari
  // document.body.append(uploadInput);
  // final List<String> images = await completer.future;
  // audioPath = images.first;
  // print("Images :${audioPath.toString()}");
  // uploadInput.remove();
  // InputElement uploadInput = FileUploadInputElement();
  // uploadInput.click();
  //
  // uploadInput.onChange.listen((event) {
  //   final file = uploadInput.files.first;
  //   final reader = FileReader();
  //   reader.(file);
  //   reader.onLoadEnd.listen((event) {
  //     uploadedImage = file;
  //     print('Here evetns completed and values is :${event.path}');
  //   });
  // });
  FilePickerResult result = await FilePicker.platform.pickFiles();

  if(result != null) {
    File file = File(result.files.single.path);
    print("Here File is : $file");
    dummyFilePath=file.path;
    print("Here File Path is : $dummyFilePath");

  } else {
    // User canceled the picker
  }

  print('Audio File is: ${result.files.first.bytes}');
  imageController.text = result.files.first.name;
  // arrayBytes = result.files.first.bytes;

  // final content = File(arrayBytes, 'fileName');
  // final anchor = AnchorElement(
  //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //   ..setAttribute("download", "file.txt")
  //   ..click();
  // print("anchor path${anchor.pathname}");
  // // File abc = await writeToFile(result.files.last.bytes);
  // // print('File is: ${abc.path}');
  if (result != null) {
    // dummyFilePath =
    //     "data:application/octet-stream;charset=utf-16le;base64,$content";
    uploadedImage = result.files.single;
    print('Audio File is:${result.files.last.path}');
    // fileController.text = result.files.last.name;
  } else {
    // User canceled the picker

  }
}

void uploadFile() async {
  // final completer = Completer<List<String>>();
  // InputElement uploadInput = FileUploadInputElement();
  // uploadInput.multiple = true;
  // uploadInput.accept = 'image/*';
  // uploadInput.click();
  // // onChange doesn't work on mobile safari
  // uploadInput.addEventListener('change', (e) async {
  //   // read file content as dataURL
  //   final files = uploadInput.files;
  //   print("files :${files.first.relativePath}");
  //   Iterable<Future<String>> resultsFutures = files.map((file) {
  //     print("files :${file.relativePath}");
  //
  //     final reader = FileReader();
  //     reader.readAsDataUrl(file);
  //     // reader.onError.listen((error) => completer.completeError(error));
  //     return reader.onLoad.first
  //         .then((value) => audioPath = value.path.toString());
  //   });
  //
  //   final results = await Future.wait(resultsFutures);
  //   completer.complete(results);
  // });
  // // need to append on mobile safari
  // document.body.append(uploadInput);
  // final List<String> images = await completer.future;
  // audioPath = images.first;
  // print("Images :${audioPath.toString()}");
  // uploadInput.remove();
  // InputElement uploadInput = FileUploadInputElement();
  // uploadInput.click();
  //
  // uploadInput.onChange.listen((event) {
  //   final file = uploadInput.files.first;
  //   final reader = FileReader();
  //   reader.(file);
  //   reader.onLoadEnd.listen((event) {
  //     uploadedImage = file;
  //     print('Here evetns completed and values is :${event.path}');
  //   });
  // });
  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['mp3'],
    withReadStream: true,
    // withReadStream: true,
  );

  print('Audio File is: ${result.files.first.bytes}');
  fileController.text = result.files.first.name;

  // arrayBytes = result.files.first.bytes;

  // final content = File(arrayBytes, 'fileName');
  // final anchor = AnchorElement(
  //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //   ..setAttribute("download", "file.txt")
  //   ..click();
  // print("anchor path${anchor.pathname}");
  // // File abc = await writeToFile(result.files.last.bytes);
  // // print('File is: ${abc.path}');
  if (result != null) {
    // dummyFilePath =
    //     "data:application/octet-stream;charset=utf-16le;base64,$content";
    uploadedFile = result.files.single;
    print('Audio File is:${result.files.last.path}');
    // fileController.text = result.files.last.name;
  } else {
    // User canceled the picker

  }
}

//
// final dbBytes = await rootBundle.load('assets/file'); // <= your ByteData
String tempPath = '';
String filePath = '';
//=======================
// Future<File> writeToFile(Uint8List data) async {
//   final buffer = data.buffer;
//   Directory tempDir = await getApplicationDocumentsDirectory();
//   tempPath = tempDir.path;
//   filePath =
//       tempPath + '/file_01.mp3'; // file_01.tmp is dump file, can be anything
//   print('File path: $filePath');
//   print('aaray bytes: $arrayBytes');
//
//   return new File(filePath)
//       .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
// }

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
            html.window.location.reload(),
            // Navigator.of(context).pop(),
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
      try {
        await SongsUtils.deleteCategory(model.objectId).whenComplete(() => {
              Navigator.of(context).pop(),
              html.window.location.reload(),
            });
      } catch (e) {
        Navigator.of(context).pop();
        html.window.location.reload();
      }
    },
  );

  PlatformFile uploadedImage;
  void uploadFile() async {
    // final completer = Completer<List<String>>();
    // InputElement uploadInput = FileUploadInputElement();
    // uploadInput.multiple = true;
    // uploadInput.accept = 'image/*';
    // uploadInput.click();
    // // onChange doesn't work on mobile safari
    // uploadInput.addEventListener('change', (e) async {
    //   // read file content as dataURL
    //   final files = uploadInput.files;
    //   print("files :${files.first.relativePath}");
    //   Iterable<Future<String>> resultsFutures = files.map((file) {
    //     print("files :${file.relativePath}");
    //
    //     final reader = FileReader();
    //     reader.readAsDataUrl(file);
    //     // reader.onError.listen((error) => completer.completeError(error));
    //     return reader.onLoad.first
    //         .then((value) => audioPath = value.path.toString());
    //   });
    //
    //   final results = await Future.wait(resultsFutures);
    //   completer.complete(results);
    // });
    // // need to append on mobile safari
    // document.body.append(uploadInput);
    // final List<String> images = await completer.future;
    // audioPath = images.first;
    // print("Images :${audioPath.toString()}");
    // uploadInput.remove();
    // InputElement uploadInput = FileUploadInputElement();
    // uploadInput.click();
    //
    // uploadInput.onChange.listen((event) {
    //   final file = uploadInput.files.first;
    //   final reader = FileReader();
    //   reader.(file);
    //   reader.onLoadEnd.listen((event) {
    //     uploadedImage = file;
    //     print('Here evetns completed and values is :${event.path}');
    //   });
    // });
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3'],
      withReadStream: true,
      // withReadStream: true,
    );

    print('Audio File is: ${result.files.first.bytes}');
    // arrayBytes = result.files.first.bytes;

    // final content = File(arrayBytes, 'fileName');
    // final anchor = AnchorElement(
    //     href: "data:application/octet-stream;charset=utf-16le;base64,$content")
    //   ..setAttribute("download", "file.txt")
    //   ..click();
    // print("anchor path${anchor.pathname}");
    // // File abc = await writeToFile(result.files.last.bytes);
    // // print('File is: ${abc.path}');
    if (result != null) {
      // dummyFilePath =
      //     "data:application/octet-stream;charset=utf-16le;base64,$content";
      uploadedImage = result.files.single;
      print('Audio File is:${result.files.last.path}');
      // fileController.text = result.files.last.name;
    } else {
      // User canceled the picker

    }
  }

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
  // fileController.text = model.musicFiles['name'].toString();
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
    onPressed: () async {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));

      // await SongsUtils().uploadFile(audioFile);

      // Songs updateSong = Songs(
      //   duration: durationController.text.toString(),
      //   songName: nameController.text.toString(),
      //   songCategory: categoryController.text.toString(),
      //   objectId: model.objectId,
      //   // musicFiles: {
      //   //   '__type': 'File',
      //   //   'name': audioFile.name,
      //   //   'url': audioFile.path,
      //   // },
      // );
      // SongsUtils.updateTodo(updateSong).whenComplete(() => {
      //       Navigator.of(context).pop(),
      //     });
      // print('Audio File: ${audioFile.name}');
    },
  );

  dynamic values;

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
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.8)),
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: DropdownButton<dynamic>(
                      hint: Text("Select item"),
                      isExpanded: true,
                      value: values,
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      onChanged: (value) {
                        values = value;
                        print('Values is : $value');
                      },
                      items: StaticData.categoryData.map((user) {
                        return DropdownMenuItem<dynamic>(
                          value: user.songCategory,
                          child: Row(
                            children: <Widget>[
                              Text(
                                user.songCategory,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
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
                  child: Center(
                    child: TextField(
                      controller: fileController,
                      textAlignVertical: TextAlignVertical.bottom,
                      onChanged: (String text) {
                        fileController.text = text;
                      },
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: MyReferences.SFPro),
                      decoration: InputDecoration(
                        hintText: 'Choose file',
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1),
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
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.8)),
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

String dummyFilePath="";
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
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.8)),
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
      // print('Audio File is: ${audioFile.path}');

      Navigator.of(context).pop();
    },
  );
  Widget continueButton = MaterialButton(
    child: Text("Add"),
    color: MyGradientColors.onBoardingGradientColorLeft,
    onPressed: () async {
      Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              AndroidProgressModel()));
      try {
        // print('Saving this file to parse: $audioPath');
        //
        // print('File here: ${File(path)}');
        Songs addSong = Songs(
          duration: durationController.text,
          songName: nameController.text,
          songCategory: categoryController.text,
          // musicFiles: {
          //   '__type': "file",
          //   'name': nameController.text,
          //   'url': uploadedImage.path,
          // },
        );

        await SongsUtils.addTodo(addSong)
            .whenComplete(() => html.window.location.reload());
        ParseObject parseObject = ParseObject("Songs");
        parseObject.set(
          "musicIcon",
          ParseFile(File(dummyFilePath.toString())),
        );
        parseObject.set(
          "song_name",
          '',
          // '${nameController.text}',
        );
        parseObject.set(
          "song_category",
          '${'values.toString()'}',
        );
        parseObject.set(
          "duration",
          '',

          // '${durationController.text}',
        );
        // print('Saving this file to parse: $audioPath');
        parseObject.set(
          "musicFiles",
          ParseFile(File(dummyFilePath.toString())),
        );
        // await parseObject.save();
      } catch (e) {
        print(e.toString());
        Navigator.of(context).pop(context);
      }
      // Songs addSong = Songs(
      //   duration: duration,
      //   songName: name.toString(),
      //   songCategory: category,
      //   // musicFiles: {
      //   //   '__type': 'File',
      //   //   'name': audioFile.name,
      //   //   'url': audioFile.bytes,
      //   // },
      // );
      // try {
      //   ParseObject parseObject = ParseObject("Songs");
      //   parseObject.set(
      //       "musicFiles", ParseFile(File(audioFile.path.toString())));
      //   parseObject.save();
      // } catch (e) {
      //   print(e);
      // }
      // SongsUtils.addTodo(addSong).whenComplete(() => {
      //       Navigator.of(context).pop(),
      //     });
      // print('Audio File: ${audioFile.name}');
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Add music"),
    content: Container(
      width: MediaQuery.of(context).size.width / 1.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Image',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Stack(
                      children: [
                        TextField(
                          controller: imageController,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (String text) {
                            // name = text;
                          },
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            top: 10,
                            child: InkWell(
                              onTap: () {
                                uploadImage();
                              },
                              child: Icon(
                                Icons.file_copy_sharp,
                                color: MyGradientColors.splashGradientColor1,
                              ),
                            ))
                      ],
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
                    'Name',
                    maxLines: 1,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: TextField(
                      controller: nameController,
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
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.8)),
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
                  child: Center(
                    child: DropdownButtonFormField(
                      hint: Text(
                        '''Select Category''',
                        style: TextStyle(
                            fontSize: 16, fontFamily: MyReferences.SFPro),
                      ),
                      value: values,
                      onChanged: (value) {
                        values = value;
                        print('category Value: $values');
                      },
                      onTap: () {},
                      items: [
                        for (int i = 0; i < StaticData.categoryData.length; i++)
                          DropdownMenuItem(
                            value: StaticData.categoryData[i].songCategory,
                            child: Text(
                              StaticData.categoryData[i].songCategory,
                            ),
                          ),
                      ],
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    // TextField(
                    //   controller: categoryController,
                    //   textAlignVertical: TextAlignVertical.bottom,
                    //   onChanged: (String text) {
                    //     category = text;
                    //   },
                    //   style: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 14,
                    //       fontFamily: MyReferences.SFPro),
                    //   decoration: InputDecoration(
                    //     hintText: 'Select category',
                    //     hintStyle: TextStyle(color: Colors.grey),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Colors.grey, width: 1),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide:
                    //           BorderSide(color: Colors.grey.withOpacity(0.8)),
                    //     ),
                    //   ),
                    // ),
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
                  child: Center(
                    child: Stack(
                      children: [
                        TextField(
                          controller: nameController,
                          textAlignVertical: TextAlignVertical.bottom,
                          onChanged: (String text) {
                            name = text;
                          },
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
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.8)),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 10,
                            top: 10,
                            child: InkWell(
                              onTap: () {
                                uploadFile();
                              },
                              child: Icon(
                                Icons.file_copy_sharp,
                                color: MyGradientColors.splashGradientColor1,
                              ),
                            ))
                      ],
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
                  child: Center(
                    child: TextField(
                      controller: durationController,
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
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.8)),
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

      try {
        SongsUtils.addToCategory(addSong).whenComplete(() => {
              Navigator.of(context).pop(),
              html.window.location.reload(),
            });
      } catch (e) {
        Navigator.of(context).pop();
        html.window.location.reload();
      }
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
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0.8)),
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
