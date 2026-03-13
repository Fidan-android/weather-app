import 'package:weather_app/features/city/data/datasource/city_datasource.dart';
import 'package:weather_app/features/city/data/dto/city/city_dto.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/city/domain/repository/i_city_repo.dart';

class CityRepoImpl implements ICityRepo {
  final CityDataSource db;

  CityRepoImpl(this.db);

  @override
  Future<List<CityModel>> onGetCityByQuery(String query) async {
    // `take` for pagination
    final cities = await db.onSearchCity(query, take: 15);
    return cities.map((dto) => dto.toDomain()).toList();
  }

  @override
  List<CityModel> onGetHistory() {
    final history = db.onGetHistory();
    return history.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<dynamic> onSelectCity(CityModel cityModel) async {
    await db.onSelectCity(CityDto.fromDomain(cityModel));
  }

  @override
  Future<dynamic> onRemoveCity(CityModel cityModel) async {
    await db.onRemoveCity(CityDto.fromDomain(cityModel));
  }

  @override
  CityModel? onGetSelectedCity() {
    final cityDto = db.onGetSelectedCity();
    return cityDto?.toDomain();
  }
}
