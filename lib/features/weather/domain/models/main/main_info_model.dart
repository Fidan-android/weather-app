class MainInfoModel {
  final double? currentTemp; // Текущая температура
  final double? feelsLike; // Ощущается как
  final double? minTemp; // Минимальная темпераутра
  final double? maxTemp; //Максимальная температура
  final double? pressure; // Давление
  final double? humidity; // Влажность

  MainInfoModel(
    this.currentTemp,
    this.feelsLike,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.humidity,
  );
}
