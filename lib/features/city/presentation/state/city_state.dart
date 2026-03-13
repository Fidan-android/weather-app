import 'package:weather_app/features/city/domain/models/city_model.dart';

sealed class CityState {}

class CityInitState extends CityState {}

class CityLoadingState extends CityState {}

class CityDataState extends CityState {
  List<CityModel> cities = [];

  CityDataState(this.cities);
}

class CityErrorState extends CityState {
  String errorMessage;

  CityErrorState(this.errorMessage);
}
