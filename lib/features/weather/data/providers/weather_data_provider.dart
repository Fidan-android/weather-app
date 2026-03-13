import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/core/network/dio_provider.dart';
import 'package:weather_app/core/providers/prefs_provider.dart';
import 'package:weather_app/features/weather/data/api/weather_api.dart';
import 'package:weather_app/features/weather/data/datasource/weather_datasource.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository.dart';

final weatherApiProvider = Provider((ref) {
  return WeatherApi(ref.read(apiServiceProvider));
});

final weatherDataSourceProvider = Provider<WeatherDatasource>((ref) {
  return WeatherDatasource(ref.read(sharedPrefsProvider));
});

final weatherRepositoryProvider = Provider((ref) {
  return WeatherRepository(
    ref.read(weatherApiProvider),
    ref.read(connectionInfoProvider),
    ref.read(weatherDataSourceProvider),
  );
});

final selectedUnitProvider = StateProvider<Units>((ref) => Units.metric);
