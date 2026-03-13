import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/forecast/domain/models/forecast_model.dart';
import 'package:weather_app/features/weather/data/dto/response/weather_response_dto.dart';

part "forecast_response_dto.g.dart";

@JsonSerializable(explicitToJson: true)
class ForecastResponseDto {
  @JsonKey(name: "code")
  final String? code;

  @JsonKey(name: "message")
  final int? message;

  @JsonKey(name: "cnt")
  final int? count;

  @JsonKey(name: "list")
  List<WeatherResponseDto> listOfWeather;

  ForecastResponseDto({
    required this.code,
    required this.message,
    required this.count,
    required this.listOfWeather,
  });

  factory ForecastResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ForecastResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ForecastResponseDtoToJson(this);

  ForecastModel toDomain() {
    return ForecastModel(
      code,
      message,
      count,
      listOfWeather.map((e) => e.toDomain()).toList(),
    );
  }
}
