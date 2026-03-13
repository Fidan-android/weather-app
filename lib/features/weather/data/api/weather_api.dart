import 'package:flutter/foundation.dart';
import 'package:weather_app/core/network/api_service.dart';
import 'package:weather_app/features/weather/data/dto/response/weather_response_dto.dart';

class WeatherApi {
  final ApiService _apiService;

  WeatherApi(this._apiService);

  Future<WeatherResponseDto> getWeather(
    String lat,
    String lon,
    String units,
  ) async {
    final response = await _apiService.get(
      path: "/weather",
      query: {"lat": lat, "lon": lon, "units": units},
    );
    debugPrint(response.toString());
    return WeatherResponseDto.fromJson(response);
  }
}
