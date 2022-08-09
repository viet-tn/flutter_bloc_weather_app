import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/settings.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/save_settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final SaveSettings saveSettings;

  SettingsBloc(this.getSettings, this.saveSettings)
      : super(
          SettingsState(
            Settings(
              theme: SchedulerBinding.instance.window.platformBrightness ==
                      Brightness.dark
                  ? WeatherAppTheme.dark
                  : WeatherAppTheme.light,
              metric: WeatherMetric.celcius,
            ),
          ),
        ) {
    on<LoadSettingEvent>(_onLoadSettingEvent);
    on<ChangeWeatherAppThemeEvent>(_onChangeWeatherAppThemeEvent);
    on<ChangeWeatherMetricEvent>(_onChangeWeatherMetricEvent);
  }

  FutureOr<void> _onLoadSettingEvent(
      LoadSettingEvent event, Emitter<SettingsState> emit) async {
    log('_onLoadSettingEvent called');
    final settings = await getSettings(params: NoParam());
    settings.fold(
      (failure) {
        log('settings_bloc: getSettings failure');
        emit(
          SettingsState(
            Settings(
              theme: SchedulerBinding.instance.window.platformBrightness ==
                      Brightness.dark
                  ? WeatherAppTheme.dark
                  : WeatherAppTheme.light,
              metric: WeatherMetric.celcius,
            ),
          ),
        );
      },
      (value) {
        log('settings_bloc: getSettings success ${value.theme.name}');
        emit(SettingsState(value));
      },
    );
  }

  FutureOr<void> _onChangeWeatherAppThemeEvent(
      ChangeWeatherAppThemeEvent event, Emitter<SettingsState> emit) async {
    final newState =
        state.copyWith(settings: state.settings.copyWith(theme: event.theme));

    final result = await saveSettings(params: newState.settings);
    result.fold(
      (l) => log('save error'),
      (r) => log('save success ${newState.settings.theme.name}'),
    );
    emit(newState);
  }

  FutureOr<void> _onChangeWeatherMetricEvent(
      ChangeWeatherMetricEvent event, Emitter<SettingsState> emit) async {
    final newState =
        state.copyWith(settings: state.settings.copyWith(metric: event.metric));

    await saveSettings(params: newState.settings);
    emit(newState);
  }
}
