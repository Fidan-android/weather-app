import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/city/presentation/providers/city_provider.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

class CityController extends Notifier<CityState> {
  CityModel? _selectedCity;

  @override
  CityState build() => CityInitState();

  Future onInit() async {
    final repository = ref.read(cityRepositoryProvider);
    _selectedCity = await repository.onGetSelectedCity();
    state = CityDataState([], _selectedCity);
  }

  Future onSearch(String query) async {
    final repository = ref.read(cityRepositoryProvider);
    try {
      state = CityLoadingState();
      final cities = query.isEmpty
          ? await repository.onGetHistory()
          : await repository.onGetCityByQuery(query);
      state = CityDataState(cities, _selectedCity);
    } catch (e) {
      state = CityErrorState(e.toString());
    }
  }

  Future onSelectCity(CityModel city) async {
    _selectedCity = city;
    final repository = ref.read(cityRepositoryProvider);
    await repository.onSelectCity(city);
    state = CityDataState([], _selectedCity);
  }

  Future onRemoveCity(CityModel city) async {
    final repository = ref.read(cityRepositoryProvider);
    await repository.onRemoveCity(city);
    state = CityDataState(await repository.onGetHistory(), _selectedCity);
  }

  void onClearSearch() {
    state = CityDataState([], _selectedCity);
  }
}
