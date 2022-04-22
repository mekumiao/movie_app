import 'package:design/design.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_api/movie_api.dart';
import 'package:movie_repository/movie_repository.dart';
import 'package:remote_movie_api/remote_movie_api.dart';
import 'package:utils/util.dart';

part 'setting_event.dart';
part 'setting_state.dart';
part 'setting_bloc.g.dart';

class SettingBloc extends HydratedBloc<SettingEvent, SettingState> {
  SettingBloc({
    required ConfigRepository configRepository,
  })  : _configRepository = configRepository,
        super(const SettingState()) {
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<LanguageCodeChanged>(_onLanguageCodeChanged);
    on<HostIndexChanged>(_onHostIndexChanged);
    on<HostsFetched>(_onHostsFetched);
    on<UserChanged>(_onUserChanged);
  }

  final ConfigRepository _configRepository;

  void _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(mode: event.mode));
  }

  void _onLanguageCodeChanged(
    LanguageCodeChanged event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(languageCode: event.languageCode));
  }

  Future<void> _onHostIndexChanged(
    HostIndexChanged event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(hostIndex: event.index));
    await SpUtil.putString(Constant.apiHost, state.selectedHost.host);
    ApiHelper.resetInstance();
  }

  Future<void> _onHostsFetched(
    HostsFetched event,
    Emitter<SettingState> emit,
  ) async {
    try {
      final hosts = await _configRepository.getAllHostConfigs();
      hosts.insertAll(0, defaultHosts);
      emit(state.copyWith(hosts: hosts));
    } catch (e) {
      showToast(e.toString());
    }
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<SettingState> emit,
  ) {
    emit(state.copyWith(user: event.user));
  }

  @override
  SettingState? fromJson(Map<String, dynamic> json) => SettingState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(SettingState state) => state.toJson();
}
