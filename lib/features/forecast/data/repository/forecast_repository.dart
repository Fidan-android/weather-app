import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/core/network/connection_info.dart';
import 'package:weather_app/features/forecast/data/api/forecast_api.dart';
import 'package:weather_app/features/forecast/data/datasource/forecast_datasource.dart';
import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';
import 'package:weather_app/features/forecast/domain/repository/i_forecast_repository.dart';

class ForecastRepository extends IForecastRepository {
  final ForecastApi _forecastApi;
  final ConnectionInfo _connectionInfo;
  final ForecastDatasource _datasource;

  ForecastRepository(this._forecastApi, this._connectionInfo, this._datasource);

  bool get isOffline => _isOffline;
  bool _isOffline = false;

  @override
  Future<ForecastModel> onGetForecast(
    String lat,
    String lon,
    Units unit,
  ) async {
    if (!await _connectionInfo.isConnected) {
      _isOffline = true;
      final cashedForecast = _datasource.onGetCashedForecast(unit);
      if (cashedForecast != null) {
        return cashedForecast.toDomain();
      }
      throw Exception("Нет интернет соединения");
    }

    _isOffline = false;
    try {
      final response = await _forecastApi.getWeather(lat, lon, unit.type);
      await _datasource.onSaveForecast(response, unit);
      return response.toDomain();
    } on DioException catch (e) {
      debugPrintStack(stackTrace: e.stackTrace);
      throw Exception("Что-то пошло не так! Попробуй снова.");
    }
  }
}
