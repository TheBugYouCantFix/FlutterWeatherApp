import 'dart:convert';

final class Weather {
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final int humidity;
  final int pressure;
  final String weatherDescription;

  const Weather({required this.temperature, required this.feelsLike, required this.windSpeed, required this.humidity, required this.pressure, required this.weatherDescription});
  factory Weather.fromOpenWeatherApiJson(String jsonData, [int? nDays]) {
    Map<String, dynamic> data;

    if (nDays != null) {
      data = jsonDecode(jsonData)['list'][nDays]; 
    } else {
      data = jsonDecode(jsonData);
    }

    return Weather(
      temperature: data['main']['temp'],
      feelsLike: data['main']['feels_like'],
      windSpeed: data['wind']['speed'],
      humidity: data['main']['humidity'],
      pressure: data['main']['pressure'],
      weatherDescription: data['weather'][0]['description'],
    );
  }
  factory Weather.defaultWeather() => const Weather(temperature: 0, feelsLike: 0, windSpeed: 0, humidity: 0, pressure: 0, weatherDescription: '');
}