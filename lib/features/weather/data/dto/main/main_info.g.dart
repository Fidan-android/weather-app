// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainInfo _$MainInfoFromJson(Map<String, dynamic> json) => MainInfo(
  (json['temp'] as num?)?.toDouble(),
  (json['feels_like'] as num?)?.toDouble(),
  (json['temp_min'] as num?)?.toDouble(),
  (json['temp_max'] as num?)?.toDouble(),
  (json['pressure'] as num?)?.toDouble(),
  (json['humidity'] as num?)?.toDouble(),
);

Map<String, dynamic> _$MainInfoToJson(MainInfo instance) => <String, dynamic>{
  'temp': instance.currentTemp,
  'feels_like': instance.feelsLike,
  'temp_min': instance.minTemp,
  'temp_max': instance.maxTemp,
  'pressure': instance.pressure,
  'humidity': instance.humidity,
};
