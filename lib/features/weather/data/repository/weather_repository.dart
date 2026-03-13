import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/core/network/connection_info.dart';
import 'package:weather_app/features/weather/data/api/weather_api.dart';
import 'package:weather_app/features/weather/data/datasource/weather_datasource.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/repository/i_weather_repository.dart';

class WeatherRepository implements IWeatherRepository {
  final WeatherApi _weatherApi;
  final ConnectionInfo _connectionInfo;
  final WeatherDatasource _datasource;

  WeatherRepository(this._weatherApi, this._connectionInfo, this._datasource);

  bool get isOffline => _isOffline;
  bool _isOffline = false;

  @override
  Future<WeatherModel> onGetWeather(String lat, String lon, Units unit) async {
    if (!await _connectionInfo.isConnected) {
      _isOffline = true;
      final cashedWeather = _datasource.onGetCashedWeather(unit);
      if (cashedWeather != null) {
        return cashedWeather.toDomain();
      }
      throw Exception("Нет интернет соединения");
    }

    _isOffline = false;
    try {
      final response = await _weatherApi.getWeather(lat, lon, unit.type);
      await _datasource.onSaveWeather(response, unit);
      return response.toDomain();
    } on DioException catch (e) {
      debugPrintStack(stackTrace: e.stackTrace);
      throw Exception("Что-то пошло не так, попробуй позже.");
    }
  }

  @override
  Future<void> onSelectUnit(Units unit) async {
    await _datasource.onSelectUnit(unit);
  }

  @override
  Units onGetSelectedUnit() {
    return _datasource.onGetSelectedUnit() ?? Units.metric;
  }
}
