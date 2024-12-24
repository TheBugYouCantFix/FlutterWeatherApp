import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';

import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/models/coordinates.dart';
import 'package:flutter_weather_app/repositories/weather_repository.dart';

final class OpenWeatherApiWeatherRepository extends WeatherRepository {
  static const String baseUrl = 'http://api.openweathermap.org';
  static final apiKey = dotenv.env['API_KEY'];
  
  const OpenWeatherApiWeatherRepository._internal();
  static const OpenWeatherApiWeatherRepository _instance = OpenWeatherApiWeatherRepository._internal();
  factory OpenWeatherApiWeatherRepository() => _instance;

  @override
  Future<Either<String, Coordinates>> getCoordinatesFromCityName(String city) async {
    final url = '$baseUrl/geo/1.0/direct?q=$city&limit=1&appid=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = response.body;
      Map<String, dynamic> data = jsonDecode(jsonData)[0];

      return right(Coordinates(latitude: data['lat'], longitude: data['lon']));
    } 

    return left('Failed to get coordinates');
  }

  @override
  Future<Either<String, Weather>> getWeatherToday(String city) async {
    final eitherCoordinates = await getCoordinatesFromCityName(city);
    return eitherCoordinates.fold(
      (error) => left(error), 
      (coordinates) => getWeatherTodayFromCoordinates(coordinates)
    );
  }

  Either<String, Weather> getWeatherByResponse(http.Response response) {
    if (response.statusCode == 200) {
      final jsonData = response.body;
      Weather weather = Weather.fromOpenWeatherApiJson(jsonData);
      return right(weather);
    }

    return left('Failed to get weather');
  }

  Future<Either<String, Weather>> getWeatherTodayFromCoordinates(Coordinates coordinates) async {
    final url = '$baseUrl/data/3.0/onecall?lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    return getWeatherByResponse(response);
  }

  @override
  Future<Either<String, List<Weather>>> getWeatherNdaysAhead(int nDays, String city) async {
    final eitherCoordinates = await getCoordinatesFromCityName(city);
    List<Weather> nDaysAheadWeather = [];
    
    for (int i = 1; i <= nDays; i++) {
      eitherCoordinates.fold(
        (error) => left(error), 
        (coordinates) async => (await getWeatherForecastFromCoordinates(coordinates, i * 24 * 60 * 60)).fold(
            (error) => left(error), 
            (weather) => nDaysAheadWeather.add(weather)
          )
      );
    }

    return right(nDaysAheadWeather);
  } 

  Future<Either<String, Weather>> getWeatherForecastFromCoordinates(Coordinates coordinates, int unixTimeDelta) async {
    final int unixTime = (DateTime.now().millisecondsSinceEpoch / 1000).round() + unixTimeDelta;
    final url = '$baseUrl/data/3.0/onecall/timemachine?lat=${coordinates.latitude}&lon=${coordinates.longitude}&dt=$unixTime&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    return getWeatherByResponse(response);
  }
} 