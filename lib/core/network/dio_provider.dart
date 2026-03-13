import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/config/env.dart';
import 'package:weather_app/core/network/api_service.dart';
import 'package:weather_app/core/network/connection_info.dart';

const weatherBaseUrl = "https://api.openweathermap.org/data/2.5";

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: weatherBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final buffer = StringBuffer();
        buffer
          ..writeln("--- chain.request ---")
          ..writeln("type: ${options.method}")
          ..writeln("url: ${options.path}${options.queryParameters}");
        debugPrint(buffer.toString());

        options.queryParameters["appid"] = Env.weatherApiKey;
        options.queryParameters["lang"] = "ru";
        handler.next(options);
      },
    ),
  );

  return dio;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.read(dioProvider));
});

final connectionInfoProvider = Provider<ConnectionInfo>((ref) {
  return ConnectionInfo(Connectivity());
});

final connectivityProvider = StreamProvider((ref) {
  return Connectivity().onConnectivityChanged;
});
