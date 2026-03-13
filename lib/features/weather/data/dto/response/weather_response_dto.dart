import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/data/dto/main/main_info.dart';
import 'package:weather_app/features/weather/data/dto/weather/weather_info.dart';
import 'package:weather_app/features/weather/data/dto/wind/wind_info.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';

part "weather_response_dto.g.dart";

@JsonSerializable(explicitToJson: true)
class WeatherResponseDto {
  @JsonKey(name: "weather")
  final List<WeatherInfo> weather;

  @JsonKey(name: "main")
  final MainInfo main;

  @JsonKey(name: "visibility")
  final int visibility;

  @JsonKey(name: "wind")
  final WindInfo wind;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "dt_txt")
  final String? dateTime;

  WeatherResponseDto(
    this.weather,
    this.main,
    this.visibility,
    this.wind,
    this.name,
    this.dateTime,
  );

  factory WeatherResponseDto.fromJson(Map<String, dynamic> json) {
    return _$WeatherResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherResponseDtoToJson(this);

  WeatherModel toDomain() {
    return WeatherModel(
      weather.map((dto) => dto.toDomain()).toList(),
      main.toDomain(),
      wind.toDomain(),
      visibility,
      name,
    );
  }
}
