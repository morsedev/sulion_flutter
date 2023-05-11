import 'package:sulion_app/src/core/session/domain/entity/session_info_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/shared/domain/use_case/base_use_case.dart';
import 'package:sulion_app/src/core/shared/types/none.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class RefreshTokenUseCase
    extends StreamUseCase<SessionInfoEntity, None> {
  RefreshTokenUseCase(this._sessionRepository);
  final SessionRepository _sessionRepository;
  @override
  Stream<ResultHolder<SessionInfoEntity, ErrorModel>> call([None param]);
}
