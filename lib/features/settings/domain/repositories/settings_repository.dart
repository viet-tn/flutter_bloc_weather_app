import 'package:dartz/dartz.dart';
import '../entities/settings.dart';

import '../../../../core/error/failures.dart';

abstract class SettingsRepository {
  Future<Either<Failure, Settings>> getSettings();
  Future<Either<Failure, void>> saveSettings(Settings settings);
}
