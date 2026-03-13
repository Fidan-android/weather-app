import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/enums/shared_keys.dart';
import 'package:weather_app/features/city/data/dto/city/city_dto.dart';

class CityDb {
  final countOfHistory = 5;
  List<CityDto>? _cachedCities;

  SharedPreferences? _prefs;
  List<CityDto> _historyCities = [];

  Future _initPrefs() async {
    if (_prefs != null) return;
    _prefs = await SharedPreferences.getInstance();
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
    if (_historyCities.isEmpty) {
      final historyString = _prefs?.getStringList(SharedKeys.history.key) ?? [];
      _historyCities = historyString
          .map((e) => CityDto.fromJson(jsonDecode(e)))
          .toList();
    }
    return _historyCities;
  }

  Future onSelectCity(CityDto city) async {
    if (_historyCities.length == countOfHistory) {
      _historyCities.removeAt(0);
    }
    if (!_historyCities.map((e) => e.name).contains(city.name)) {
      _historyCities.add(city);
    }

    await _prefs?.setString(
      SharedKeys.selectedCity.key,
      jsonEncode(city.toJson()),
    );
    await _prefs?.setStringList(
      SharedKeys.history.key,
      _historyCities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future onRemoveCity(CityDto city) async {
    _historyCities.removeWhere((dto) => dto.name == city.name);
    await _prefs?.setStringList(
      SharedKeys.history.key,
      _historyCities.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }

  Future<CityDto?> onGetSelectedCity() async {
    await _initPrefs();
    final jsonString = _prefs?.getString(SharedKeys.selectedCity.key) ?? "";
    print(jsonString);
    if (jsonString.isEmpty) return null;
    return CityDto.fromJson(jsonDecode(jsonString));
  }
}
