import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
      : super(LoadingSettingState()) {
    on<FetchSettingEvent>(_onLoadSettingEvent);
    on<ChangeWeatherAppThemeEvent>(_onChangeWeatherAppThemeEvent);
    on<ChangeWeatherMetricEvent>(_onChangeWeatherMetricEvent);
  }

  FutureOr<void> _onLoadSettingEvent(
      FetchSettingEvent event, Emitter<SettingsState> emit) async {
    log('_onLoadSettingEvent called');
    final settings = await getSettings(params: NoParam());
    settings.fold(
      (failure) {
        log('settings_bloc: getSettings failure');
        emit(
          const LoadedSettingsState(Settings.defaultSettings),
        );
      },
      (value) {
        log('settings_bloc: getSettings success ${value.theme.name}');
        emit(LoadedSettingsState(value));
      },
    );
  }

  FutureOr<void> _onChangeWeatherAppThemeEvent(
      ChangeWeatherAppThemeEvent event, Emitter<SettingsState> emit) async {
    late LoadedSettingsState newState;
    if (state is LoadedSettingsState) {
      newState = (state as LoadedSettingsState).copyWith(
        settings: (state as LoadedSettingsState)
            .settings
            .copyWith(theme: event.theme),
      );
    } else {
      newState = const LoadedSettingsState(Settings.defaultSettings);
    }
    final result = await saveSettings(params: newState.settings);
    result.fold(
      (l) => log('save error'),
      (r) => log('save success ${newState.settings.theme.name}'),
    );
    emit(newState);
  }

  FutureOr<void> _onChangeWeatherMetricEvent(
      ChangeWeatherMetricEvent event, Emitter<SettingsState> emit) async {
    late LoadedSettingsState newState;
    if (state is LoadedSettingsState) {
      newState = (state as LoadedSettingsState).copyWith(
        settings: (state as LoadedSettingsState)
            .settings
            .copyWith(metric: event.metric),
      );
    } else {
      newState = const LoadedSettingsState(Settings.defaultSettings);
    }
    await saveSettings(params: newState.settings);
    emit(newState);
  }
}
