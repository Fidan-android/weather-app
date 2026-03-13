import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

class WeatherController extends Notifier<WeatherState> {
  @override
  WeatherState build() => WeatherInitState();

  Future onInit() async {
    final repository = ref.read(weatherRepository);
  }

  Future onLoadWeather() async {}
}
