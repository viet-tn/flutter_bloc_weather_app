import 'dart:developer';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../datasources/settings_local_data_source.dart';
import '../models/settings_model.dart';
import '../../domain/entities/settings.dart';
import '../../domain/repositories/settings_repository.dart';

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
      return const Right(null);
    } catch (e) {
      log(e.runtimeType.toString());
      return Left(CacheFailure());
    }
  }
}
