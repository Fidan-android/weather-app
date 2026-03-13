import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/core/network/dio_provider.dart';
import 'package:weather_app/core/providers/prefs_provider.dart';
import 'package:weather_app/features/forecast/data/api/forecast_api.dart';
import 'package:weather_app/features/forecast/data/datasource/forecast_datasource.dart';
import 'package:weather_app/features/forecast/data/repository/forecast_repository.dart';
import 'package:weather_app/features/weather/data/api/weather_api.dart';
import 'package:weather_app/features/weather/data/datasource/weather_datasource.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository.dart';

final forecastApiProvider = Provider((ref) {
  return ForecastApi(ref.read(apiServiceProvider));
});

final forecastDatasourceProvider = Provider((ref) {
  return ForecastDatasource(ref.read(sharedPrefsProvider));
});

final forecastRepositoryProvider = Provider((ref) {
  return ForecastRepository(
    ref.read(forecastApiProvider),
    ref.read(connectionInfoProvider),
    ref.read(forecastDatasourceProvider),
  );
});
