part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ThemeModeChanged extends SettingEvent {
  const ThemeModeChanged({
    required this.mode,
  });

  final ThemeMode mode;

  @override
  List<Object> get props => [mode];
}

class LanguageCodeChanged extends SettingEvent {
  const LanguageCodeChanged({
    required this.languageCode,
  });

  final String languageCode;

  @override
  List<Object> get props => [languageCode];
}

class HostIndexChanged extends SettingEvent {
  const HostIndexChanged({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class HostsFetched extends SettingEvent {
  const HostsFetched();
}

class UserChanged extends SettingEvent {
  const UserChanged({required this.user});

  final UserDto user;
}
