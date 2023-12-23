import 'package:shared_preferences/shared_preferences.dart';

class ImagePathHandler {
  static const String imagePathKey = 'image_path_key';
  static const String nameKey = 'name_key';

  static Future<void> saveImagePath(String imagePath) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(imagePathKey, imagePath);
  }

  static Future<String?> getImagePath() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(imagePathKey);
  }

  static Future<void> saveName(String name, String number, String gender, String dob, String address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(nameKey, [name, gender, dob, address, number]);
  }

  static Future<List<String>?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(nameKey);
  }
}
