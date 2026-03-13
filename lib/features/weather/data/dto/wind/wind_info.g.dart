// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wind_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WindInfo _$WindInfoFromJson(Map<String, dynamic> json) => WindInfo(
  (json['speed'] as num?)?.toDouble(),
  (json['deg'] as num?)?.toDouble(),
  (json['gust'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WindInfoToJson(WindInfo instance) => <String, dynamic>{
  'speed': instance.speed,
  'deg': instance.deg,
  'gust': instance.gust,
};
