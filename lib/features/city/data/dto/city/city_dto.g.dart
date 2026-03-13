// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityDto _$CityDtoFromJson(Map<String, dynamic> json) => CityDto(
  coords: CoordsModel.fromJson(json['coords'] as Map<String, dynamic>),
  name: json['name'] as String,
  district: json['district'] as String?,
  subject: json['subject'] as String?,
);

Map<String, dynamic> _$CityDtoToJson(CityDto instance) => <String, dynamic>{
  'coords': instance.coords.toJson(),
  'name': instance.name,
  'district': instance.district,
  'subject': instance.subject,
};
