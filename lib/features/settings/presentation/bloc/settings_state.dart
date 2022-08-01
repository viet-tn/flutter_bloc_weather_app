part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final Settings settings;
  const SettingsState(this.settings);

  @override
  List<Object> get props => [settings];

  SettingsState copyWith({
    Settings? settings,
  }) {
    return SettingsState(
      settings ?? this.settings,
    );
  }
}
