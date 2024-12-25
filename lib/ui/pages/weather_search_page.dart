import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_app/ui/pages/todays_weather_page.dart';
import 'package:flutter_weather_app/ui/popups/error_snack_bar.dart';
import 'package:flutter_weather_app/ui/widgets/city_input_field.dart';
import 'package:flutter_weather_app/ui/widgets/multi_weather_data.dart';
import '../../cubit/weather_cubit.dart';

class WeatherSearchPage extends StatelessWidget {
  const WeatherSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.read<WeatherCubit>().reset(), icon: const Icon(Icons.home)),
        title: const Text("Поиск погоды"),
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status == WeatherStatus.weatherError) {
              showErrorSnackBar(context, state.errorMessage!);
            }
          },
          builder: (context, state) {
            if (state.status == WeatherStatus.initial) {
              return const CityInputField();
            } else if (state.status == WeatherStatus.todaysWeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == WeatherStatus.todaysWeatherLoaded) {
              return TodaysWeatherPage(weather: state.weather!, city: state.city!);
            } else if (state.status == WeatherStatus.nDaysAheadWeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == WeatherStatus.nDaysAheadWeatherLoaded) {
              return MultiWeatherData(weatherList: state.nDaysAheadWeather!, city: state.city!);
            }

            return const CityInputField();
          }
        ),
      ),
    );
  }
}
