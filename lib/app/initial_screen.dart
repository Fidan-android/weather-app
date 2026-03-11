import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_conditions/flutter_weather_conditions.dart';
import 'package:go_router/go_router.dart';

class InitialScreen extends ConsumerStatefulWidget {
  const InitialScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  @override
  void initState() {
    super.initState();

    // Здесь можно добавить проверку на авторизацию
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        context.replace("/city");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                WeatherConditionsIcons.wiSunrise,
                color: Colors.yellow,
                size: 52,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Weather App",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
