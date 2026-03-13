import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/data/providers/city_data_provider.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

class CityController extends Notifier<CityState> {
  @override
  CityState build() => CityInitState();

  void onInit() {
    final repository = ref.read(cityRepositoryProvider);
    ref.read(selectedCityProvider.notifier).state = repository
        .onGetSelectedCity();
  }

  Future onSearch(String query) async {
    final repository = ref.read(cityRepositoryProvider);
    try {
      state = CityLoadingState();
      final cities = query.isEmpty
          ? repository.onGetHistory()
          : await repository.onGetCityByQuery(query);
      state = CityDataState(cities);
    } catch (e) {
      state = CityErrorState(e.toString());
    }
  }

  Future onSelectCity(CityModel city) async {
    ref.read(selectedCityProvider.notifier).state = city;
    final repository = ref.read(cityRepositoryProvider);
    await repository.onSelectCity(city);
  }

  Future onRemoveCity(CityModel city) async {
    final repository = ref.read(cityRepositoryProvider);
    await repository.onRemoveCity(city);
    state = CityDataState(repository.onGetHistory());
  }

  void onClearSearch() {
    state = CityDataState([]);
  }
}
