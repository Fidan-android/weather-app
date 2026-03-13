import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/data/providers/city_data_provider.dart';
import 'package:weather_app/features/forecast/data/providers/forecast_data_provider.dart';
import 'package:weather_app/features/forecast/presentation/state/forecast_state.dart';
import 'package:weather_app/features/weather/data/providers/weather_data_provider.dart';

class ForecastController extends Notifier<ForecastState> {
  @override
  ForecastState build() {
    ref.listen(selectedCityProvider, (prev, next) {
      if (next != null) {
        _loadForecast();
      }
    });
    ref.listen(selectedUnitProvider, (prev, next) {
      _loadForecast();
    });

    Future.microtask(_loadForecast);
    return ForecastInitState();
  }

  Future<void> onRefresh() async {
    state = ForecastLoadingState();
    await _loadForecast();
  }

  Future<void> _loadForecast() async {
    final unit = ref.read(selectedUnitProvider);
    final city = ref.read(selectedCityProvider);

    if (city == null) {
      state = ForecastErrorState(
        "Выберите город на вкладке Города для показа погоды",
      );
      return;
    }

    final repository = ref.read(forecastRepositoryProvider);
    state = ForecastLoadingState();
    try {
      final forecast = await repository.onGetForecast(
        city.latitude,
        city.longitude,
        unit,
      );
      state = ForecastDataState(forecast, isOffline: repository.isOffline);
    } on DioException catch (e) {
      state = ForecastErrorState("Отсутствует инетрнет-соединение");
    } catch (e) {
      state = ForecastErrorState(e.toString());
    }
  }
}
