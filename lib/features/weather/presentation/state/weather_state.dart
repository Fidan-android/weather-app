import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';

sealed class WeatherState {}

class WeatherInitState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherErrorState extends WeatherState {
  final String errorMessage;

  WeatherErrorState(this.errorMessage);
}

class WeatherDataState extends WeatherState {
  final Units unit;
  final bool isOffline;
  final WeatherModel weatherModel;

  WeatherDataState(
    this.weatherModel, {
    this.isOffline = false,
    this.unit = Units.metric,
  });
}
