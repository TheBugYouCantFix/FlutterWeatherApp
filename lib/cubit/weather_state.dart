part of 'weather_cubit.dart';

enum WeatherStatus {
  initial,
  todaysWeatherLoading,
  todaysWeatherLoaded,
  nDaysAheadWeatherLoading,
  nDaysAheadWeatherLoaded,
  weatherError,
}

final class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather? weather;
  final String? city;
  final List<Weather>? nDaysAheadWeather;
  final String? errorMessage;

  const WeatherState({
    this.status = WeatherStatus.initial,
    this.weather,
    this.city,
    this.nDaysAheadWeather = const [],
    this.errorMessage
  });

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    String? city,
    List<Weather>? nDaysAheadWeather,
    String? errorMessage
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      city: city ?? this.city,
      nDaysAheadWeather: nDaysAheadWeather ?? this.nDaysAheadWeather,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, weather, city, nDaysAheadWeather, errorMessage];
}
