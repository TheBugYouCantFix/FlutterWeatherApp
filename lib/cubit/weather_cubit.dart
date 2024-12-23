import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/models/weather.dart';

import 'package:flutter_weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(const WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> getWeatherToday(String city) async {
    emit(state.copyWith(status: WeatherStatus.todaysWeatherLoading));
    final eitherWeather = await _weatherRepository.getWeatherToday(city);
    eitherWeather.fold(
      (error) => emit(state.copyWith(status: WeatherStatus.todaysWeatherError, errorMessage: error)),
      (weather) => emit(state.copyWith(status: WeatherStatus.todaysWeatherLoaded, weather: weather)),
    );
  }

  Future<void> getWeatherNdaysAhead(int nDays, String city) async {
    emit(state.copyWith(status: WeatherStatus.nDaysAheadWeatherLoading));
    final eitherWeather = await _weatherRepository.getWeatherNdaysAhead(nDays, city);
    eitherWeather.fold(
      (error) => emit(state.copyWith(status: WeatherStatus.nDaysAheadWeatherError, errorMessage: error)),
      (weather) => emit(state.copyWith(status: WeatherStatus.nDaysAheadWeatherLoaded, nDaysAheadWeather: weather)),
    );
  }
}
