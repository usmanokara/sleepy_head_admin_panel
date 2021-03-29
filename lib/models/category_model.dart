import 'dart:convert';

List<CategoryModel> todoFromJson(String str) => List<CategoryModel>.from(
    json.decode(str).map((x) => CategoryModel.fromJson(x)));

String todoToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  String objectId;
  String songCategory;

  CategoryModel({
    this.songCategory,
    this.objectId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        songCategory: json["song_category"],
        objectId: json["objectId"],
      );

  Map<String, dynamic> toJson() => {
        "song_category": songCategory,
        "objectId": objectId,
      };
}
