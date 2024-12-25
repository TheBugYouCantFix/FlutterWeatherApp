import 'package:flutter/material.dart';

class CityProvider with ChangeNotifier {
  String? _cityName;
  String get cityName => _cityName ?? 'Москва';

  void setCityName(String newCity) {
    _cityName = newCity;
    notifyListeners();
  }
}
