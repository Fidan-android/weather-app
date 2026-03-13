import 'package:weather_app/features/weather/domain/models/weather_model.dart';

class ForecastModel {
  final String? code;

  final int? message;

  final int? count;

  List<WeatherModel> listOfWeather;

  ForecastModel(this.code, this.message, this.count, this.listOfWeather);
}
