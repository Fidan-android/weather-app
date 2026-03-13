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
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherControllerProvider);
    return _buildBody(weatherState);
  }

  Widget _buildBody(WeatherState weatherState) {
    if (weatherState is WeatherLoadingState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator()],
      );
    }

    if (weatherState is WeatherErrorState) {
      return RefreshIndicator(
        onRefresh: ref.read(weatherControllerProvider.notifier).onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weatherState.errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (weatherState is WeatherDataState) {
      final unit = ref.watch(selectedUnitProvider);
      final weather = weatherState.weatherModel.weather.first;
      return RefreshIndicator(
        onRefresh: ref.read(weatherControllerProvider.notifier).onRefresh,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
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
                      Text(
                        "•	Влажность: ${weatherState.weatherModel.main.humidity}",
                      ),
                      Text(
                        "•	Скорость ветра: ${weatherState.weatherModel.wind.speed}",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Градусы °C"),
                          Switch(
                            value: unit == Units.imperial,
                            onChanged: (isChanged) {
                              ref
                                  .read(weatherControllerProvider.notifier)
                                  .onChangeUnit(
                                    isChanged ? Units.imperial : Units.metric,
                                  );
                            },
                          ),
                          Text("Фаренгейты °F"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (weatherState.isOffline)
                Column(
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
            ],
          ),
        ),
      );
    }

    return Column(children: [SizedBox.shrink()]);
  }
}
