import 'dart:convert';

List<Songs> todoFromJson(String str) =>
    List<Songs>.from(json.decode(str).map((x) => Songs.fromJson(x)));

String todoToJson(List<Songs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Songs {
  String objectId;
  String songName;
  String songCategory;
  String duration;
  bool isLiked;
  dynamic musicFiles;
  Songs({
    this.objectId,
    this.songName,
    this.songCategory,
    this.duration,
    this.isLiked,
    this.musicFiles,
  });

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
        objectId: json["objectId"],
        songName: json["song_name"],
        songCategory: json["song_category"],
        duration: json["duration"],
        isLiked: json["is_favorite"],
        musicFiles: json["musicFiles"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "song_name": songName,
        "song_category": songCategory,
        "duration": duration,
        "is_favorite": isLiked,
        "musicFiles": musicFiles,
      };
}
