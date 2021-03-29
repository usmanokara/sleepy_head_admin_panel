import 'dart:convert';

import 'package:http/http.dart';
import 'package:sleepy_head_panel/constants/static_data.dart';
import 'package:sleepy_head_panel/models/category_model.dart';
import 'package:sleepy_head_panel/models/songs.dart';
import 'package:sleepy_head_panel/network_utils/song_utils.dart';

class GetData {
  Future<List<Songs>> getTodoList() async {
    StaticData.categoryData = [];
    Response response = await SongsUtils.getTodoList();
    print("Code is ${response.statusCode}");
    print("Response is ${response.body}");

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var results = body["results"];

      for (var songs in results) {
        StaticData.apiData.add(Songs.fromJson(songs));
      }
    } else {
      //Handle error
    }
    return StaticData.apiData;
  }

  Future<List<CategoryModel>> getTodoList1() async {
    StaticData.categoryData = [];
    Response response = await SongsUtils.getCategoryTodoList();
    print("Code is ${response.statusCode}");
    print("Category Response is ${response.body}");

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      var results = body["results"];

      for (var category in results) {
        StaticData.categoryData.add(CategoryModel.fromJson(category));
      }
    } else {
      //Handle error
    }

    return StaticData.categoryData;
  }
  //
  // Future<List<Favorites>> getFavoritesList() async {
  //   StaticData.favoritesData = [];
  //   Response response = await SongsUtils.getFavoritesList();
  //   print("Code is ${response.statusCode}");
  //   print("Favorite List Response is ${response.body}");
  //
  //   if (response.statusCode == 200) {
  //     var body = json.decode(response.body);
  //     var results = body["results"];
  //
  //     for (var favorites in results) {
  //       StaticData.favoritesData.add(Favorites.fromJson(favorites));
  //     }
  //   } else {
  //     //Handle error
  //   }
  //
  //   return StaticData.favoritesData;
  // }
}
