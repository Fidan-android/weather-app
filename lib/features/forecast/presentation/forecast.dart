import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/forecast/presentation/provider/forecast_provider.dart';
import 'package:weather_app/features/forecast/presentation/state/forecast_state.dart';
import 'package:weather_app/features/weather/domain/models/weather_model.dart';

class ForecastScreen extends ConsumerStatefulWidget {
  const ForecastScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends ConsumerState<ForecastScreen> {
  @override
  Widget build(BuildContext context) {
    final forecastState = ref.watch(forecastControllerProvider);
    return _buildBody(forecastState);
  }

  Widget _buildBody(ForecastState forecastState) {
    if (forecastState is ForecastLoadingState) {
      return Column(children: [CircularProgressIndicator()]);
    }

    if (forecastState is ForecastErrorState) {
      return RefreshIndicator(
        onRefresh: ref.read(forecastControllerProvider.notifier).onRefresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  forecastState.errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (forecastState is ForecastDataState) {
      final list = forecastState.forecastModel.listOfWeather;
      return RefreshIndicator(
        onRefresh: ref.read(forecastControllerProvider.notifier).onRefresh,
        child: list.isEmpty
            ? SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(child: Text("Нет прогнозов")),
              )
            : Column(
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                      child: ListView.builder(
                        itemCount:
                            forecastState.forecastModel.listOfWeather.length,
                        itemBuilder: (ctx, index) {
                          final weather =
                              forecastState.forecastModel.listOfWeather[index];
                          return _forecastBlock(weather);
                        },
                      ),
                    ),
                  ),
                  if (forecastState.isOffline)
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
      );
    }

    return Column(children: [SizedBox.shrink()]);
  }

  Widget _forecastBlock(WeatherModel weather) {
    final weatherInfo = weather.weather.first;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: BoxBorder.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                color: Colors.blue,
                child: CachedNetworkImage(
                  fit: BoxFit.fitWidth,
                  imageUrl: weatherInfo.icon ?? "",
                  width: 80,
                  height: 80,
                  errorWidget: (_, _, _) => Icon(Icons.error),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Мин температура: ${weather.main.minTemp}"),
                Text("Макс температура: ${weather.main.maxTemp}"),
                Text("Погода: ${weatherInfo.description}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
