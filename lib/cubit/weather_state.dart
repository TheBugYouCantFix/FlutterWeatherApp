part of 'weather_cubit.dart';

enum WeatherStatus {
  initial,
  todaysWeatherLoading,
  todaysWeatherLoaded,
  todaysWeatherError,
  nDaysAheadWeatherLoading,
  nDaysAheadWeatherLoaded,
}

final class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather? weather;
  final List<Weather>? nDaysAheadWeather;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.nDaysAheadWeather = const [],
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    List<Weather>? nDaysAheadWeather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      nDaysAheadWeather: nDaysAheadWeather ?? this.nDaysAheadWeather,
    );
  }

  @override
  List<Object?> get props => [status, weather, nDaysAheadWeather];
}
