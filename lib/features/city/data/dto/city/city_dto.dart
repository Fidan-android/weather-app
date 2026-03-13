import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/city/data/dto/coords/coords_model.dart';
import 'package:weather_app/features/city/domain/models/city_model.dart';

part "city_dto.g.dart";

@JsonSerializable(explicitToJson: true)
class CityDto {
  @JsonKey(name: "coords")
  final CoordsModel coords;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "district")
  String? district;

  @JsonKey(name: "subject")
  String? subject;

  CityDto({
    required this.coords,
    required this.name,
    this.district,
    this.subject,
  });

  factory CityDto.fromJson(Map<String, dynamic> json) {
    return _$CityDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CityDtoToJson(this);

  CityModel toDomain() => CityModel(
    name: name,
    latitude: coords.latitude,
    longitude: coords.longitude,
  );

  factory CityDto.fromDomain(CityModel model) {
    return CityDto(
      coords: CoordsModel(model.latitude, model.longitude),
      name: model.name,
    );
  }
}
