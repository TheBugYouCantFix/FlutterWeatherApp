import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_weather_app/cubit/weather_cubit.dart';
import 'package:flutter_weather_app/provider/city_provider.dart';
import 'package:flutter_weather_app/ui/pages/weather_search_page.dart';
import 'package:flutter_weather_app/repositories/api_weather_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CityProvider(),
      child: MaterialApp(
        title: 'Material App',
        home: BlocProvider(
          create: (context) => WeatherCubit(OpenWeatherApiWeatherRepository()),
          child: const WeatherSearchPage(),
        ),
      ),
    );
  }
}
