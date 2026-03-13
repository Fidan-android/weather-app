import 'package:flutter/foundation.dart';
import 'package:weather_app/core/network/api_service.dart';
import 'package:weather_app/features/forecast/data/dto/forecast_response_dto.dart';
import 'package:weather_app/features/weather/data/dto/response/weather_response_dto.dart';

class ForecastApi {
  final ApiService _apiService;

  ForecastApi(this._apiService);

  Future<ForecastResponseDto> getWeather(
    String lat,
    String lon,
    String units, {
    int count = 5,
  }) async {
    final response = await _apiService.get(
      path: "/forecast",
      query: {"lat": lat, "lon": lon, "units": units, "cnt": count},
    );
    debugPrint(response.toString());
    return ForecastResponseDto.fromJson(response);
  }
}
