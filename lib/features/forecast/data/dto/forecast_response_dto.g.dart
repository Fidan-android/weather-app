// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastResponseDto _$ForecastResponseDtoFromJson(Map<String, dynamic> json) =>
    ForecastResponseDto(
      code: json['code'] as String?,
      message: (json['message'] as num?)?.toInt(),
      count: (json['cnt'] as num?)?.toInt(),
      listOfWeather: (json['list'] as List<dynamic>)
          .map((e) => WeatherResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastResponseDtoToJson(
  ForecastResponseDto instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'cnt': instance.count,
  'list': instance.listOfWeather.map((e) => e.toJson()).toList(),
};
