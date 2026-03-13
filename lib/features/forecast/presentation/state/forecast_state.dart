import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';

sealed class ForecastState {}

class ForecastInitState extends ForecastState {}

class ForecastLoadingState extends ForecastState {}

class ForecastErrorState extends ForecastState {
  final String errorMessage;

  ForecastErrorState(this.errorMessage);
}

class ForecastDataState extends ForecastState {
  final ForecastModel forecastModel;
  final bool isOffline;

  ForecastDataState(this.forecastModel, {this.isOffline = false});
}
