import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/domain/models/main/main_info_model.dart';

part 'main_info.g.dart';

@JsonSerializable(explicitToJson: true)
class MainInfo {
  @JsonKey(name: "temp")
  final double currentTemp;

  @JsonKey(name: "feels_like")
  final double feelsLike;

  @JsonKey(name: "temp_min")
  final String minTemp;

  @JsonKey(name: "temp_max")
  final String maxTemp;

  @JsonKey(name: "pressure")
  final double pressure;

  @JsonKey(name: "humidity")
  final double humidity;

  MainInfo(
    this.currentTemp,
    this.feelsLike,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.humidity,
  );

  factory MainInfo.fromJson(Map<String, dynamic> json) {
    return _$MainInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MainInfoToJson(this);

  MainInfoModel toDomain() {
    return MainInfoModel(
      currentTemp,
      feelsLike,
      minTemp,
      maxTemp,
      pressure,
      humidity,
    );
  }
}
