import 'package:shared_preferences/shared_preferences.dart';

const String savedCurrencies = 'SAVEDCURRENCIES';

class AppSharedData {
  late SharedPreferences secureStorage;

  AppSharedData(SharedPreferences preferences) {
    secureStorage = preferences;
  }

  setData(String key, String value) {
    secureStorage.setString(key, value);
  }

  String getData(String key) {
    if (secureStorage.containsKey(key)) {
      return secureStorage.getString(key)!;
    } else {
      return "";
    }
  }

  bool hasData(String key) {
    return secureStorage.containsKey(key);
  }

  clearData(String key) {
    secureStorage.remove(key);
  }
}
