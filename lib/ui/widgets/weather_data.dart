import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/weather.dart';

class WeatherDataWidget extends StatelessWidget {
  final Weather weather;
  final String city;
  final int nDays; // number of days passed since the current day

  const WeatherDataWidget({super.key, required this.weather, required this.city, required this.nDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Погода в городе $city ${getTimeDescription()}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 8),
          Text(
            "Температура: ${weather.temperature}°C\n Ощущается как: ${weather.feelsLike}°C \n Скорость ветра: ${weather.windSpeed} м/с \n Влажность: ${weather.humidity}% \n Давление: ${weather.pressure} мм рт. ст.",
            style: const TextStyle(fontSize: 14),
          )
        ]
      )
    );
  }

  String getTimeDescription() {
    switch (nDays) {  
      case 0:
        return "сегодня";
      case 1:
        return "завтра";
      default:
        return "через $nDays дней";
    }
  }
}