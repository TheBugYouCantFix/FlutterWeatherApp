import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_app/cubit/weather_cubit.dart';
import 'package:flutter_weather_app/provider/city_provider.dart';

class CityInputField extends StatelessWidget {
  const CityInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) {
          context.read<WeatherCubit>().getWeatherToday(value);
          context.read<CityProvider>().setCityName(value);
        },
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Название города",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}