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
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.nDaysAheadWeather = const [],
    this.errorMessage
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    List<Weather>? nDaysAheadWeather,
    String? errorMessage
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      nDaysAheadWeather: nDaysAheadWeather ?? this.nDaysAheadWeather,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, weather, nDaysAheadWeather, errorMessage];
}
