import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/city/data/providers/city_data_provider.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/weather/data/providers/weather_data_provider.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

class WeatherController extends Notifier<WeatherState> {
  @override
  WeatherState build() {
    final selectedCity = ref.watch(selectedCityProvider);
    if (selectedCity == null) {
      return WeatherErrorState(
        "Выберите город на вкладке Города для показа погоды",
      );
    }
    return WeatherLoadingState();
  }

  Future<void> onInit() async {
    final repository = ref.read(weatherRepositoryProvider);
    final selectedUnit = repository.onGetSelectedUnit();
    ref.read(selectedUnitProvider.notifier).state = selectedUnit;

    final selectedCity = ref.read(selectedCityProvider);
    if (selectedCity != null) {
      await _loadWeather(selectedCity, selectedUnit);
    }
  }

  Future<void> _loadWeather(CityModel city, Units unit) async {
    final repository = ref.read(weatherRepositoryProvider);
    try {
      final weather = await repository.onGetWeather(
        city.latitude,
        city.longitude,
        ref.read(selectedUnitProvider),
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

    final selectedCity = ref.read(selectedCityProvider);
    if (selectedCity != null) {
      await _loadWeather(selectedCity, unit);
    }
  }
}
