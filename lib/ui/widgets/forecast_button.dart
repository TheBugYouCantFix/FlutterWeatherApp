import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/cubit/weather_cubit.dart';
import 'package:flutter_weather_app/provider/city_provider.dart';

class ForecastButton extends StatelessWidget {
  static const int nDays = 2; // number of days for the forecast
  const ForecastButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final city = context.read<CityProvider>().cityName;
        context.read<WeatherCubit>().getWeatherNdaysAhead(nDays, city);
      },
      child: const Text('Прогноз погоды'),
    );
  }
}