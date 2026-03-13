import 'package:json_annotation/json_annotation.dart';

part 'coords_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CoordsModel {
  @JsonKey(name: "lat")
  final String latitude;
  @JsonKey(name: "lon")
  final String longitude;

  CoordsModel(this.latitude, this.longitude);

  factory CoordsModel.fromJson(Map<String, dynamic> json) {
    return _$CoordsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CoordsModelToJson(this);
}
