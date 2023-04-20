import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class UseCase<Result, Parameter> {
  Result call(Parameter param);
}

abstract class BaseUseCase<Result, Param>
    implements UseCase<Future<ResultHolder<Result, ErrorModel>>, Param> {
  @override
  Future<ResultHolder<Result, ErrorModel>> call(Param param);
}
