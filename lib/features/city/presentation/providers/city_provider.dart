import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/presentation/controller/city_controller.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

final cityControllerProvider = NotifierProvider<CityController, CityState>(
  CityController.new,
);
