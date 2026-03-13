import 'package:weather_app/features/city/domain/models/city_model.dart';

abstract class ICityRepo {
  Future<List<CityModel>> onGetCityByQuery(String query);

  List<CityModel> onGetHistory();

  Future onSelectCity(CityModel cityModel);

  Future onRemoveCity(CityModel cityModel);

  CityModel? onGetSelectedCity();
}
