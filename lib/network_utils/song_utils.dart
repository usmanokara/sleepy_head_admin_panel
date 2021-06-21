import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:sleepy_head_panel/constants/constants.dart';
import 'package:sleepy_head_panel/models/category_model.dart';
import 'package:sleepy_head_panel/models/songs.dart';

class SongsUtils {
  static final String _baseUrl = "https://parseapi.back4app.com/classes/";
  //Create
  SongsUtils();
  static Future<Response> addTodo(Songs songs) async {
    String apiUrl = _baseUrl + "Songs";

    Response response = await post(
      apiUrl,
      headers: {
        'X-Parse-Application-Id': kParseApplicationId,
        'X-Parse-REST-API-Key': kParseRestApiKey,
        'Content-Type': 'application/json'
      },
      body: json.encode(songs.toJson()),
    );

    return response;
  }

  Future<void> uploadFile(dynamic path) async {
    var postUri = Uri.parse(_baseUrl + "Songs");
    var request = new http.MultipartRequest("POST", postUri);
    request.fields['musicFiles'] = 'blah';
    request.files.add(new http.MultipartFile.fromBytes(
      'file',
      await File.fromRawPath(path.readAsBytesSync()).readAsBytes(),
    ));
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
  }

  static Future<Response> addToCategory(CategoryModel category) async {
    String apiUrl = _baseUrl + "category";

    Response response = await post(
      apiUrl,
      headers: {
        'X-Parse-Application-Id': kParseApplicationId,
        'X-Parse-REST-API-Key': kParseRestApiKey,
        'Content-Type': 'application/json'
      },
      body: json.encode(category.toJson()),
    );

    return response;
  }

  static Future<Response> addToFavourites(Songs songs) async {
    String apiUrl = _baseUrl + "favorites";

    Response response = await post(
      apiUrl,
      headers: {
        'X-Parse-Application-Id': kParseApplicationId,
        'X-Parse-REST-API-Key': kParseRestApiKey,
        'Content-Type': 'application/json'
      },
      body: json.encode(songs.toJson()),
    );

    return response;
  }

  //Read
  static Future getTodoList() async {
    String apiUrl = _baseUrl + "Songs";

    Response response = await get(apiUrl, headers: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-REST-API-Key': kParseRestApiKey,
    });

    return response;
  }

  static Future getCategoryTodoList() async {
    String apiUrl = _baseUrl + "category";
    Response response = await get(apiUrl, headers: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-REST-API-Key': kParseRestApiKey,
    });

    return response;
  }

  static Future getFavoritesList() async {
    String apiUrl = _baseUrl + "favorites";

    Response response = await get(apiUrl, headers: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-REST-API-Key': kParseRestApiKey,
    });

    return response;
  }

  //Update
  static Future updateTodo(Songs songs) async {
    String apiUrl = _baseUrl + "Songs/${songs.objectId}";

    Response response = await put(apiUrl,
        headers: {
          'X-Parse-Application-Id': kParseApplicationId,
          'X-Parse-REST-API-Key': kParseRestApiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode(songs.toJson()));
    print('Update response: ${response.body}');
    return response;
  }

  static Future updateCategory(CategoryModel songs) async {
    String apiUrl = _baseUrl + "category/${songs.objectId}";

    Response response = await put(apiUrl,
        headers: {
          'X-Parse-Application-Id': kParseApplicationId,
          'X-Parse-REST-API-Key': kParseRestApiKey,
          'Content-Type': 'application/json',
        },
        body: json.encode(songs.toJson()));
    print('Update response: ${response.body}');
    return response;
  }

  //Delete
  static Future deleteTodo(String objectId) async {
    String apiUrl = _baseUrl + "Songs/$objectId";

    Response response = await delete(apiUrl, headers: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-REST-API-Key': kParseRestApiKey,
    });

    return response;
  }

  static Future deleteCategory(String objectId) async {
    String apiUrl = _baseUrl + "category/$objectId";

    Response response = await delete(apiUrl, headers: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-REST-API-Key': kParseRestApiKey,
    });

    return response;
  }
}
