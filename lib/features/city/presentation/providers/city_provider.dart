import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/data/datasource/city_db.dart';
import 'package:weather_app/features/city/data/repository/city_repo_impl.dart';
import 'package:weather_app/features/city/domain/repository/i_city_repo.dart';
import 'package:weather_app/features/city/presentation/controller/city_controller.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

final cityControllerProvider = NotifierProvider<CityController, CityState>(
  CityController.new,
);

final cityDbProvider = Provider<CityDb>((ref) => CityDb());

final cityRepositoryProvider = Provider<ICityRepo>((ref) {
  return CityRepoImpl(ref.read(cityDbProvider));
});
