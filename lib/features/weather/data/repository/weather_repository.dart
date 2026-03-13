import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/core/network/connection_info.dart';
import 'package:weather_app/features/weather/data/api/weather_api.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repository/i_weather_repository.dart';

class WeatherRepository implements IWeatherRepository {
  final WeatherApi _weatherApi;
  final ConnectionInfo _connectionInfo;

  WeatherRepository(this._weatherApi, this._connectionInfo);

  @override
  Future<WeatherModel> onGetWeather(String lat, String lon, Units unit) async {
    if (!await _connectionInfo.isConnected) {
      throw Exception("Нет интернета");
    }

    try {
      final response = await _weatherApi.getWeather(lat, lon, unit.type);
      return response.toDomain();
    } on DioException catch (e) {
      debugPrintStack(stackTrace: e.stackTrace);
      throw Exception("Что-то пошло не так, попробуй позже.");
    }
  }
}
