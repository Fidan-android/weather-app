class MainInfoModel {
  final double currentTemp; // Текущая температура
  final double feelsLike; // Ощущается как
  final String minTemp; // Минимальная темпераутра
  final String maxTemp; //Максимальная температура
  final double pressure; // Давление
  final double humidity; // Влажность

  MainInfoModel(
    this.currentTemp,
    this.feelsLike,
    this.minTemp,
    this.maxTemp,
    this.pressure,
    this.humidity,
  );
}
