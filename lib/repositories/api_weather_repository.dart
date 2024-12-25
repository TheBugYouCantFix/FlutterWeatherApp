import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';

import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/models/coordinates.dart';
import 'package:flutter_weather_app/repositories/weather_repository.dart';

final class OpenWeatherApiWeatherRepository extends WeatherRepository {
  static const String baseUrl = 'https://api.openweathermap.org';
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

    return left('Не удалось получить координаты');
  }

  @override
  Future<Either<String, Weather>> getWeatherToday(String city) async {
    final eitherCoordinates = await getCoordinatesFromCityName(city);
    return eitherCoordinates.fold(
      (error) => left(error), 
      (coordinates) => getWeatherTodayFromCoordinates(coordinates)
    );
  }

  Either<String, Weather> getWeatherByResponse(http.Response response, [int? nDays]) {
    if (response.statusCode != 200) {
      return left('Не удалось получить данные о погоде');
    }

    final jsonData = response.body;
    Weather weather;
    if (nDays != null) {
      weather = Weather.fromOpenWeatherApiJson(jsonData, nDays);
    } else {
      weather = Weather.fromOpenWeatherApiJson(jsonData);
    }
    
    return right(weather);    
  }

  Future<Either<String, Weather>> getWeatherTodayFromCoordinates(Coordinates coordinates) async {
    final url = '$baseUrl/data/2.5/weather?lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    return getWeatherByResponse(response);
  }

  @override
  Future<Either<String, List<Weather>>> getWeatherNdaysAhead(int nDays, String city) async {
    final Either<String, Coordinates> eitherCoordinates = await getCoordinatesFromCityName(city);
    List<Weather> nDaysAheadWeather = [];

    if (eitherCoordinates.isLeft()) {
      return left('Не удалось получить координаты');
    }

    for (int i = 1; i <= nDays; i++) {
      final weather = await getWeatherForecastFromCoordinates(eitherCoordinates.getOrElse(() => Coordinates(latitude: 0, longitude: 0)), i);
      
      if (weather.isLeft()) {
        return left('Не удалось получить данные о погоде');
      }

      nDaysAheadWeather.add(weather.getOrElse(() => Weather.defaultWeather()));
    }

    return right(nDaysAheadWeather);
  } 

  Future<Either<String, Weather>> getWeatherForecastFromCoordinates(Coordinates coordinates, int nDays) async {
    final url = '$baseUrl/data/2.5/forecast?lat=${coordinates.latitude}&lon=${coordinates.longitude}&exclude=minutely,hourly,alerts&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    return getWeatherByResponse(response, nDays);
  }
} 