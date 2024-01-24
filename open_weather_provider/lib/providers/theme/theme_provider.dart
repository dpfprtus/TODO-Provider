import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:open_weather_provider/constants/constants.dart';
import 'package:open_weather_provider/providers/providers.dart';
import 'package:state_notifier/state_notifier.dart';

part 'theme_state.dart';

class ThemeProvider extends StateNotifier<ThemeState> with LocatorMixin {
  ThemeProvider() : super(ThemeState.inital());

  @override
  void update(Locator watch) {
    final wp = watch<WeatherState>().weather;
    if (wp.temp > kWarmOrNot) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }
    // TODO: implement update
    super.update(watch);
  }
  // ThemeState get state {
  //   if (wp.state.weather.temp > kWarmOrNot) {
  //     return ThemeState();
  //   } else {
  //     return ThemeState(appTheme: AppTheme.dark);
  //   }
  // }
}
