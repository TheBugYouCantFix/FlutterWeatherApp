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
      (error) => emit(state.copyWith(status: WeatherStatus.weatherError, errorMessage: error)),
      (weather) => emit(state.copyWith(status: WeatherStatus.todaysWeatherLoaded, city: city, weather: weather)),
    );
  }

  Future<void> getWeatherNdaysAhead(int nDays, String city) async {
    emit(state.copyWith(status: WeatherStatus.nDaysAheadWeatherLoading));
    final eitherWeather = await _weatherRepository.getWeatherNdaysAhead(nDays, city);
    eitherWeather.fold(
      (error) => emit(state.copyWith(status: WeatherStatus.weatherError, errorMessage: error)),
      (weather) => emit(state.copyWith(status: WeatherStatus.nDaysAheadWeatherLoaded, city: city, nDaysAheadWeather: weather)),
    );
  }

  void reset() => emit(state.copyWith(status: WeatherStatus.initial));
  void goBack() {
    if (state.status == WeatherStatus.nDaysAheadWeatherLoaded || state.status == WeatherStatus.nDaysAheadWeatherLoading) {
      emit(state.copyWith(status: WeatherStatus.todaysWeatherLoaded));
    } else if (state.status == WeatherStatus.todaysWeatherLoaded || state.status == WeatherStatus.todaysWeatherLoading) {
      emit(state.copyWith(status: WeatherStatus.initial));
    }
  }
}
