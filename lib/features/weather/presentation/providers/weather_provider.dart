import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/network/dio_provider.dart';
import 'package:weather_app/core/providers/prefs_provider.dart';
import 'package:weather_app/features/weather/data/api/weather_api.dart';
import 'package:weather_app/features/weather/data/datasource/weather_datasource.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository.dart';
import 'package:weather_app/features/weather/presentation/controller/weather_controller.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

final weatherApiProvider = Provider((ref) {
  return WeatherApi(ref.read(apiServiceProvider));
});

final weatherRepository = Provider((ref) {
  return WeatherRepository(
    ref.read(weatherApiProvider),
    ref.read(connectionInfoProvider),
  );
});

final weatherControllerProvider =
    NotifierProvider<WeatherController, WeatherState>(WeatherController.new);

final weatherDataSourceProvider = Provider<WeatherDatasource>((ref) {
  final SharedPreferences prefs = ref
      .watch(sharedPrefsProvider)
      .maybeWhen(orElse: () => throw UnimplementedError());
  return WeatherDatasource(prefs);
});
