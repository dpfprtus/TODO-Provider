// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_provider.dart';

enum AppTheme {
  light,
  dark,
}

class ThemeState extends Equatable {
  final AppTheme appTheme;

  ThemeState({this.appTheme = AppTheme.light});

  factory ThemeState.inital() {
    return ThemeState();
  }

  @override
  // TODO: implement props
  List<Object?> get props => [appTheme];

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }

  @override
  bool get stringify => true;
}
