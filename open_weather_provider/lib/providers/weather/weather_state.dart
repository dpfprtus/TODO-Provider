part of 'weather_provider.dart';

enum WeatherStatus {
  initial,
  loaded,
  loading,
  error,
}

class WeatherState extends Equatable {
  final WeatherStatus status;
  final Weather weather;
  final CustomError error;
  WeatherState({
    required this.status,
    required this.weather,
    required this.error,
  });

  factory WeatherState.inital() {
    return WeatherState(
      status: WeatherStatus.initial,
      weather: Weather.initial(),
      error: CustomError(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, weather, error];

  WeatherState copyWith({
    WeatherStatus? status,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status ?? this.status,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}
