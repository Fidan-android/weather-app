import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/providers/prefs_provider.dart';
import 'package:weather_app/features/city/data/datasource/city_datasource.dart';
import 'package:weather_app/features/city/data/repository/city_repo_impl.dart';
import 'package:weather_app/features/city/domain/repository/i_city_repo.dart';
import 'package:weather_app/features/city/presentation/controller/city_controller.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

final cityControllerProvider = NotifierProvider<CityController, CityState>(
  CityController.new,
);

final cityDataSourceProvider = Provider<CityDataSource>((ref) {
  final SharedPreferences prefs = ref
      .watch(sharedPrefsProvider)
      .maybeWhen(orElse: () => throw UnimplementedError());
  return CityDataSource(prefs);
});

final cityRepositoryProvider = Provider<ICityRepo>((ref) {
  return CityRepoImpl(ref.read(cityDataSourceProvider));
});
