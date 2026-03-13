import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';

abstract class IWeatherRepository {
  Future<WeatherModel> onGetWeather(String lat, String lon, Units units);
  Future<void> onSelectUnit(Units unit);
  Units? onGetSelectedUnit();
}
