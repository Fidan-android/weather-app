import 'package:weather_app/features/city/data/datasource/city_db.dart';
import 'package:weather_app/features/city/data/dto/city/city_dto.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';
import 'package:weather_app/features/city/domain/repository/i_city_repo.dart';

class CityRepoImpl implements ICityRepo {
  final CityDb db;

  CityRepoImpl(this.db);

  @override
  Future<List<CityModel>> onGetCityByQuery(String query) async {
    // `take` for pagination
    final cities = await db.onSearchCity(query, take: 15);
    return cities.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<CityModel>> onGetHistory() async {
    final history = await db.onGetHistory();
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
  Future<CityModel?> onGetSelectedCity() async {
    final cityDto = await db.onGetSelectedCity();
    return cityDto?.toDomain();
  }
}
