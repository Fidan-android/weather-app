import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/domain/models/weather/weather_info_model.dart';

part 'weather_info.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherInfo {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherInfo(this.id, this.main, this.description, this.icon);

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return _$WeatherInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherInfoToJson(this);

  WeatherInfoModel toDomain() {
    return WeatherInfoModel(
      id,
      main,
      description,
      "https://openweathermap.org/img/wn/$icon@2x.png",
    );
  }
}
