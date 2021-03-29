import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:sleepy_head_panel/models/category_model.dart';
import 'package:sleepy_head_panel/models/songs.dart';

class StaticData {
  static const String baseDownloadURL =
      "https://drive.google.com/uc?export=view&id=";
  static bool mute = false;
  static bool isTimer;
  static String status = 'pause';
  static List<String> timerData;
  static ParseUser user;
  static List<Songs> apiData = [];
  static List<CategoryModel> categoryData = [];
  static List<String> favoriteMusic = [];
  static List<String> recentlyPlayed = [];
  static AssetsAudioPlayer audioPlayer;
  static PlayerState state = PlayerState.stop;
  static bool logoutPanel = false;
  static List<String> currencies = [];
}
