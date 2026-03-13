import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/domain/models/wind/wind_info_model.dart';

part 'wind_info.g.dart';

@JsonSerializable(explicitToJson: true)
class WindInfo {
  @JsonKey(name: "speed")
  final double speed; // Скорость

  @JsonKey(name: "deg")
  final double deg; // Градус

  @JsonKey(name: "gust")
  final double gust; // Порыв

  WindInfo(this.speed, this.deg, this.gust);

  factory WindInfo.fromJson(Map<String, dynamic> json) {
    return _$WindInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WindInfoToJson(this);

  WindInfoModel toDomain() {
    return WindInfoModel(speed, deg, gust);
  }
}
