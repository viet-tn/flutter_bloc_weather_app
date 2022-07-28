import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:flutter_bloc_weather_app/core/error/exceptions.dart';
import 'package:flutter_bloc_weather_app/core/error/failures.dart';
import 'package:flutter_bloc_weather_app/features/settings/data/datasources/settings_local_data_source.dart';
import 'package:flutter_bloc_weather_app/features/settings/data/models/settings_model.dart';
import 'package:flutter_bloc_weather_app/features/settings/domain/entities/settings.dart';
import 'package:flutter_bloc_weather_app/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Settings>> getSettings() async {
    try {
      final settings = await localDataSource.getSettings();
      return Right(settings);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveSettings(Settings settings) async {
    final settingsModel =
        SettingsModel(theme: settings.theme, metric: settings.metric);
    try {
      localDataSource.cacheSettings(settingsModel);
      return Right(() {});
    } catch (e) {
      log(e.runtimeType.toString());
      return Left(CacheFailure());
    }
  }
}
