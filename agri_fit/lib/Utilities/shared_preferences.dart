import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //singleton design
  Future<void> init() async{
    _pref = await SharedPreferences.getInstance();
  }

  late SharedPreferences _pref;

  Future<bool> resetSettings() async{
    return _pref.clear();
  }

  //helper method to manage default values of prefernces without the need to call the specific getType method of SharedPreferences
  dynamic _getFromDisk(String key, {dynamic defaultVal}) {
    var value = _pref.get(key);
    if (value == null) {
      _saveToDisk(key, defaultVal);
      return defaultVal;
    } else if (value is List) {
      var val = _pref.getStringList(key);
      return val;
    }
    return value;
  }

  //helper method to call the correct setType method of Shared Preferences
  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _pref.setString(key, content);
    }
    if (content is int) {
      _pref.setInt(key, content);
    }
    if (content is bool) {
      _pref.setBool(key, content);
    }
    if (content is double) {
      _pref.setDouble(key, content);
    }
    if (content is List<String>) {
      _pref.setStringList(key, content);
    }
    if (content == null) {
      _pref.remove(key);
    }
  }

  //Define all the keys we will need in the Preferences. Accress the value with the getter as Preferences.key
  //Getter allows us to forget the specific string used as key in the sp anf get a list of all the preferences as variables of the class

  String? get impactRefreshToken => _getFromDisk('impactRT');
  set impactRefreshToken(String? newImpactRefreshToken) =>
  _saveToDisk("impactRT", newImpactRefreshToken);

  String? get impactAccessToken => _getFromDisk('impactAT');
  set impactAccessToken(String? newImpactAccessToken) =>
  _saveToDisk("impactAT", newImpactAccessToken);

  String? get username => _getFromDisk('username');
  set username(String? newUsername) =>
  _saveToDisk("username", newUsername);

  String? get password => _getFromDisk('password');
  set password(String? newPassword) =>
  _saveToDisk("password", newPassword);

  String? get impactUsername => _getFromDisk('impactUsername');
  set impactUsername(String? newImpactUsername) =>
  _saveToDisk("impactUsername", newImpactUsername);
}