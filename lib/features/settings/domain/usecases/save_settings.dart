import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/settings.dart';
import '../repositories/settings_repository.dart';

class SaveSettings implements UseCase<void, Settings> {
  final SettingsRepository _repository;

  const SaveSettings(SettingsRepository repository) : _repository = repository;

  @override
  Future<Either<Failure, void>> call({required Settings params}) async {
    return await _repository.saveSettings(params);
  }
}
