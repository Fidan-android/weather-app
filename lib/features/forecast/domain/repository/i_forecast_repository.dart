import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';

abstract class IForecastRepository {
  Future<ForecastModel> onGetForecast(String lat, String lon, Units unit);
}
