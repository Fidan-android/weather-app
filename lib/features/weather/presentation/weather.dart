import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text("•	Текущая температура, ощущаемая температура, описание"),
          Text("•	Влажность, скорость ветра"),
          Text("•	Иконка, соответствующая погодным условиям"),
          Row(
            children: [
              Text("Градусы °C"),
              Switch(value: false, onChanged: (isChanged) {}),
              Text("Фаренгейты °F"),
            ],
          ),
        ],
      ),
    );
  }
}
