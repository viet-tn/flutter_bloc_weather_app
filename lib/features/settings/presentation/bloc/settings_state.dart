part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class LoadingSettingState extends SettingsState {}

class LoadedSettingsState extends SettingsState {
  final Settings settings;

  const LoadedSettingsState(this.settings);

  @override
  List<Object> get props => [settings];

  LoadedSettingsState copyWith({
    Settings? settings,
  }) {
    return LoadedSettingsState(
      settings ?? this.settings,
    );
  }
}
