import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/city/presentation/state/city_state.dart';

class CityController extends Notifier<CityState> {
  @override
  CityState build() => CityInitial();
}
