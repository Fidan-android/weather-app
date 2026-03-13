import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/enums/shared_keys.dart';
import 'package:weather_app/features/city/data/dto/city/city_dto.dart';

class CityDb {
  final countOfHistory = 5;
  List<CityDto>? _cachedCities;

  SharedPreferences? _sharedPreferences;
  List<CityDto> _historyCities = [];

  Future _initPrefs() async {
    if (_sharedPreferences != null) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future _loadCities() async {
    if (_cachedCities != null) return;
    final jsonString = await rootBundle.loadString("assets/data/cities.json");
    _cachedCities = (jsonDecode(jsonString) as List<dynamic>)
        .map((e) => CityDto.fromJson(e))
        .toList();
  }

  Future<List<CityDto>> onSearchCity(String query, {int take = 20}) async {
    await _loadCities();
    return _cachedCities!
        .where((city) => city.name.toLowerCase().contains(query.toLowerCase()))
        .take(take)
        .toList();
  }

  Future<List<CityDto>> onGetHistory() async {
    await _initPrefs();
    final historyString =
        _sharedPreferences?.getStringList(SharedKeys.history.key) ?? [];
    _historyCities = historyString
        .map((e) => CityDto.fromJson(jsonDecode(e)))
        .toList();
    return _historyCities;
  }

  Future onSelectCity(CityDto city) async {
    if (_historyCities.map((e) => e.name).contains(city.name)) return;

    if (_historyCities.length == countOfHistory) {
      _historyCities.removeAt(0);
    }

    _historyCities.add(city);
    await _sharedPreferences?.setString(
      SharedKeys.selectedCity.key,
      jsonEncode(city.toJson()),
    );
    await _sharedPreferences?.setStringList(
      SharedKeys.history.key,
      _historyCities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future onRemoveCity(CityDto city) async {
    _historyCities.removeWhere((dto) => dto.name == city.name);
    await _sharedPreferences?.setStringList(
      SharedKeys.history.key,
      _historyCities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
