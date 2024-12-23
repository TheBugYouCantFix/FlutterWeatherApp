import 'package:flutter_weather_app/models/coordinates.dart';
import 'package:flutter_weather_app/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeatherToday(String city);
  Future<List<Weather>> getWeatherNdaysAhead(String city);
  Future<Coordinates> getCoordinatesFromCityName(String city);
}