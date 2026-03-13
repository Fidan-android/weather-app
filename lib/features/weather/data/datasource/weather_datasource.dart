import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/enums/shared_keys.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/weather/data/dto/response/weather_response_dto.dart';

class WeatherDatasource {
  final SharedPreferences _prefs;

  WeatherDatasource(this._prefs);

  Future<void> onSaveWeather(WeatherResponseDto dto, Units unit) async {
    await _prefs.setString(unit.type, jsonEncode(dto.toJson()));
  }

  WeatherResponseDto? onGetCashedWeather(Units unit) {
    final jsonString = _prefs.getString(unit.type) ?? "";
    if (jsonString.isEmpty) return null;
    return WeatherResponseDto.fromJson(jsonDecode(jsonString));
  }

  Future<void> onSelectUnit(Units unit) async {
    await _prefs.setString(SharedKeys.selectedUnit.key, unit.type);
  }

  Units? onGetSelectedUnit() {
    final unitString = _prefs.getString(SharedKeys.selectedUnit.key) ?? "";
    if (unitString.isEmpty) return null;
    return Units.searchByType(unitString);
  }
}
