import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/models/coordinates.dart';
import 'package:flutter_weather_app/models/weather.dart';

abstract class WeatherRepository {
  Future<Either<String, Weather>> getWeatherToday(String city);
  Future<Either<String, List<Weather>>> getWeatherNdaysAhead(String city);
  Future<Either<String, Coordinates>> getCoordinatesFromCityName(String city);
}