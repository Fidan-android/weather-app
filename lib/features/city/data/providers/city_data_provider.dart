import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/core/providers/prefs_provider.dart';
import 'package:weather_app/features/city/data/datasource/city_datasource.dart';
import 'package:weather_app/features/city/data/repository/city_repo_impl.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/city/domain/repository/i_city_repo.dart';

final cityDataSourceProvider = Provider<CityDataSource>((ref) {
  return CityDataSource(ref.read(sharedPrefsProvider));
});

final cityRepositoryProvider = Provider<ICityRepo>((ref) {
  return CityRepoImpl(ref.read(cityDataSourceProvider));
});

final selectedCityProvider = StateProvider<CityModel?>((ref) => null);
