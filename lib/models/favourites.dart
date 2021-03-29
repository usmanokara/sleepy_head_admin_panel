// import 'dart:convert';
//
// List<Favorites> todoFromJson(String str) =>
//     List<Favorites>.from(json.decode(str).map((x) => Favorites.fromJson(x)));
//
// String todoToJson(List<Favorites> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class Favorites {
//   String songName;
//   String songUrl;
//   String songCategory;
//   String duration;
//
//   Favorites({
//     this.songName,
//     this.songUrl,
//     this.songCategory,
//     this.duration,
//   });
//
//   factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
//         songName: json["song_name"],
//         songUrl: json["song_url"],
//         songCategory: json["song_category"],
//         duration: json["duration"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "song_name": songName,
//         "song_url": songUrl,
//         "song_category": songCategory,
//         "duration": duration,
//       };
// }
