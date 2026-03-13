import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/forecast/presentation/controller/forecast_controller.dart';
import 'package:weather_app/features/forecast/presentation/state/forecast_state.dart';
import 'package:weather_app/features/weather/presentation/controller/weather_controller.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

final forecastControllerProvider =
    NotifierProvider<ForecastController, ForecastState>(ForecastController.new);
