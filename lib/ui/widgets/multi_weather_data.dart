import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/ui/widgets/weather_data.dart';

class MultiWeatherData extends StatelessWidget {
  final List<Weather> weatherList;
  final String city;

  const MultiWeatherData({super.key, required this.weatherList, required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < weatherList.length; i++) 
          Column(
            children: [
              WeatherDataWidget(weather: weatherList[i], city: city, nDays: i + 1),
              const SizedBox(height: 16),
            ],
          )
      ],
    );
  }
}