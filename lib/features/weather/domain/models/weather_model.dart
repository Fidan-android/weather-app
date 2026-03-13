import 'package:weather_app/features/weather/domain/models/main/main_info_model.dart';
import 'package:weather_app/features/weather/domain/models/weather/weather_info_model.dart';
import 'package:weather_app/features/weather/domain/models/wind/wind_info_model.dart';

class WeatherModel {
  final List<WeatherInfoModel> weather;
  final MainInfoModel main;
  final WindInfoModel wind;
  final int visibility; // Видимость
  final String name; // Город

  WeatherModel(this.weather, this.main, this.wind, this.visibility, this.name);
}
