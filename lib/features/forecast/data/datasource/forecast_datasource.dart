import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/enums/shared_keys.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/forecast/data/dto/forecast_response_dto.dart';
import 'package:weather_app/features/weather/data/dto/response/weather_response_dto.dart';

class ForecastDatasource {
  final SharedPreferences _prefs;

  ForecastDatasource(this._prefs);

  Future<void> onSaveForecast(ForecastResponseDto dto, Units unit) async {
    await _prefs.setString("${unit.type}_forecast", jsonEncode(dto.toJson()));
  }

  ForecastResponseDto? onGetCashedForecast(Units unit) {
    final jsonString = _prefs.getString("${unit.type}_forecast") ?? "";
    if (jsonString.isEmpty) return null;
    return ForecastResponseDto.fromJson(jsonDecode(jsonString));
  }
}
