import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> get(
    String path,
    Map<String, dynamic>? query,
  ) async {
    final response = await dio.get(path, queryParameters: query);
    return response.data;
  }

  // TODO: add another HTTP requests
}
