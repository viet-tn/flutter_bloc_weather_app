import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class GetSettings implements UseCase<Settings, void> {
  final SettingsRepository _repository;

  const GetSettings(SettingsRepository repository) : _repository = repository;

  @override
  Future<Either<Failure, Settings>> call({required void params}) async {
    return await _repository.getSettings();
  }
}
