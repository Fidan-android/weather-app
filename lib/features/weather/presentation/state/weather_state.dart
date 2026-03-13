import 'package:weather_app/features/weather/domain/models/weather_model.dart';

sealed class WeatherState {}

class WeatherInitState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherErrorState extends WeatherState {
  final String errorMessage;

  WeatherErrorState(this.errorMessage);
}

class WeatherDataState extends WeatherState {
  final WeatherModel weatherModel;
  final bool isOffline;

  WeatherDataState(this.weatherModel, {this.isOffline = false});
}
