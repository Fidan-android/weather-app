import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/city/presentation/providers/city_provider.dart';

class CityController extends Notifier<List<CityModel>> {
  @override
  List<CityModel> build() => [];

  Future onSearch(String query) async {
    final repository = ref.read(cityRepositoryProvider);
    if (query.isEmpty) {
      state = await repository.onGetHistory();
      return;
    }
    state = await repository.onGetCityByQuery(query);
  }

  Future onSelectCity(CityModel city) async {
    final repository = ref.read(cityRepositoryProvider);
    await repository.onSelectCity(city);
    onClearSearch();
  }

  Future onRemoveCity(CityModel city) async {
    final repository = ref.read(cityRepositoryProvider);
    await repository.onRemoveCity(city);
    state = await repository.onGetHistory();
  }

  void onClearSearch() {
    state = [];
  }
}
