import 'package:shared_preferences/shared_preferences.dart';

class WeatherDatasource {
  final SharedPreferences _prefs;

  WeatherDatasource(this._prefs);
}
