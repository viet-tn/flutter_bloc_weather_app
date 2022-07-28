// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entities/settings.dart';

class SettingsModel extends Settings {
  const SettingsModel({
    required super.theme,
    required super.metric,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'theme': theme.name,
      'metric': metric.name,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      theme: WeatherAppTheme.values.byName(map['theme']),
      metric: WeatherMetric.values.byName(map['metric']),
    );
  }
}
