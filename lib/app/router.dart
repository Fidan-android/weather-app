import 'package:go_router/go_router.dart';
import 'package:weather_app/app/initial_screen.dart';
import 'package:weather_app/features/city/presentation/city.dart';
import 'package:weather_app/features/forecast/presentation/forecast.dart';
import 'package:weather_app/features/home/home.dart';
import 'package:weather_app/features/settings/presentation/settings.dart';
import 'package:weather_app/features/weather/presentation/weather.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const InitialScreen()),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/city', builder: (_, _) => CityScreen())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/weather', builder: (_, _) => WeatherScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/forecast', builder: (_, _) => ForecastScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/settings', builder: (_, _) => SettingsScreen()),
          ],
        ),
      ],
    ),
  ],
);
