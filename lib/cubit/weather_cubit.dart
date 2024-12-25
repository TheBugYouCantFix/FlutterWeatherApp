import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/models/weather.dart'; 

import 'package:flutter_weather_app/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(const WeatherState());

  final WeatherRepository _weatherRepository;
  WeatherState prevState = const WeatherState();

  void emitState(WeatherState newState) {
    if (prevState.status != WeatherStatus.initial && prevState.status != state.status) {
      prevState = state;
    }

    emit(newState);
  }

  Future<void> getWeatherToday(String city) async {
    emitState(state.copyWith(status: WeatherStatus.todaysWeatherLoading));
    final eitherWeather = await _weatherRepository.getWeatherToday(city);
    eitherWeather.fold(
      (error) => emitState(state.copyWith(status: WeatherStatus.weatherError, errorMessage: error)),
      (weather) => emitState(state.copyWith(status: WeatherStatus.todaysWeatherLoaded, city: city, weather: weather)),
    );
  }

  Future<void> getWeatherNdaysAhead(int nDays, String city) async {
    emitState(state.copyWith(status: WeatherStatus.nDaysAheadWeatherLoading));
    final eitherWeather = await _weatherRepository.getWeatherNdaysAhead(nDays, city);
    eitherWeather.fold(
      (error) => emitState(state.copyWith(status: WeatherStatus.weatherError, errorMessage: error)),
      (weather) => emitState(state.copyWith(status: WeatherStatus.nDaysAheadWeatherLoaded, city: city, nDaysAheadWeather: weather)),
    );
  }

  void reset() => emitState(state.copyWith(status: WeatherStatus.initial));
}
