import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/enums/units.dart';
import 'package:weather_app/features/weather/data/providers/weather_data_provider.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/features/weather/presentation/state/weather_state.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(weatherControllerProvider.notifier).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherControllerProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildBody(weatherState),
    );
  }

  List<Widget> _buildBody(WeatherState weatherState) {
    if (weatherState is WeatherLoadingState) {
      return [CircularProgressIndicator()];
    }

    if (weatherState is WeatherErrorState) {
      return [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                weatherState.errorMessage,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Перезагрузить"),
                ),
              ),
            ],
          ),
        ),
      ];
    }

    if (weatherState is WeatherDataState) {
      final unit = ref.watch(selectedUnitProvider);
      final weather = weatherState.weatherModel.weather.first;
      return [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            color: Colors.blue,
            child: CachedNetworkImage(
              fit: BoxFit.fitWidth,
              imageUrl: weather.icon ?? "",
              width: 80,
              height: 80,
              errorWidget: (_, _, _) => Icon(Icons.error),
            ),
          ),
        ),
        Text(
          "•	Текущая температура: ${weatherState.weatherModel.main.currentTemp}",
        ),
        Text(
          "•	Ощущаемая температура: ${weatherState.weatherModel.main.feelsLike}",
        ),
        Text("•	Описание: ${weather.description}"),
        Text("•	Влажность: ${weatherState.weatherModel.main.humidity}"),
        Text("•	Скорость ветра: ${weatherState.weatherModel.wind.speed}"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Градусы °C"),
            Switch(
              value: unit == Units.imperial,
              onChanged: (isChanged) {
                ref
                    .read(weatherControllerProvider.notifier)
                    .onChangeUnit(isChanged ? Units.imperial : Units.metric);
              },
            ),
            Text("Фаренгейты °F"),
          ],
        ),
        if (weatherState.isOffline)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.deepOrangeAccent,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Нет интернет-соединения",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ];
    }

    return [SizedBox.shrink()];
  }
}
