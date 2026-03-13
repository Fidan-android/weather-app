import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/city/data/providers/city_data_provider.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/weather/data/providers/weather_data_provider.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

class WeatherController extends Notifier<WeatherState> {
  @override
  WeatherState build() {
    ref.listen(selectedCityProvider, (prev, next) {
      if (next != null) {
        _loadWeather();
      }
    });

    ref.listen(selectedUnitProvider, (prev, next) {
      _loadWeather();
    });

    Future.microtask(_loadWeather);
    return WeatherInitState();
  }

  Future<void> _loadWeather() async {
    final city = ref.read(selectedCityProvider);
    final unit = ref.read(selectedUnitProvider);

    if (city == null) {
      state = WeatherErrorState(
        "Выберите город на вкладке Города для показа погоды",
      );
      return;
    }

    final repository = ref.read(weatherRepositoryProvider);
    try {
      final weather = await repository.onGetWeather(
        city.latitude,
        city.longitude,
        unit,
      );
      state = WeatherDataState(
        weather,
        unit: unit,
        isOffline: repository.isOffline,
      );
    } catch (e) {
      state = WeatherErrorState(e.toString());
    }
  }

  Future<void> onChangeUnit(Units unit) async {
    state = WeatherLoadingState();
    final repository = ref.read(weatherRepositoryProvider);
    ref.read(selectedUnitProvider.notifier).state = unit;
    await repository.onSelectUnit(unit);
  }
}
