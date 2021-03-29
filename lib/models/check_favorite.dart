class CheckFavorite {
  // String objectId;
  String songName;
  bool isFavorite;
  CheckFavorite({
    // this.objectId,
    this.songName,
    this.isFavorite,
  });

  factory CheckFavorite.fromJson(Map<String, dynamic> json) => CheckFavorite(
        // objectId: json["objectId"],
        songName: json["name"],
        isFavorite: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        // "objectId": objectId,
        "name": songName,
        "favorite": isFavorite,
      };
}
