import 'dart:convert';

List<FileModel> todoFromJson(String str) =>
    List<FileModel>.from(json.decode(str).map((x) => FileModel.fromJson(x)));

String todoToJson(List<FileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileModel {
  // String objectId;
  String songName;
  String type;
  String url;
  FileModel({
    // this.objectId,
    this.songName,
    this.type,
    this.url,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
        // objectId: json["objectId"],
        songName: json["name"],
        type: json["__type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        // "objectId": objectId,
        "name": songName,
        "__type": type,
        "url": url,
      };
}
