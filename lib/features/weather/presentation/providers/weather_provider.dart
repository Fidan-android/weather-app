import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/presentation/controller/weather_controller.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

final weatherControllerProvider =
    NotifierProvider<WeatherController, WeatherState>(WeatherController.new);
