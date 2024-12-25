import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/ui/widgets/forecast_button.dart';
import 'package:flutter_weather_app/ui/widgets/weather_data.dart';

class TodaysWeatherPage extends StatelessWidget {
  final Weather weather;
  final String city;

  const TodaysWeatherPage({super.key, required this.weather, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherDataWidget(weather: weather, city: city, nDays: 0),
        const SizedBox(height: 16),
        const ForecastButton()
      ],
    );
  }
}