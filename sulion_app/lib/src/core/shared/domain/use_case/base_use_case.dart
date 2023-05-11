import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class UseCase<Result, Parameter> {
  Result call(Parameter param);
}

abstract class FutureUseCase<Result, Param>
    implements UseCase<Future<ResultHolder<Result, ErrorModel>>, Param> {
  @override
  Future<ResultHolder<Result, ErrorModel>> call(Param param);
}

abstract class StreamUseCase<Result, Param>
    implements UseCase<Stream<ResultHolder<Result, ErrorModel>>, Param> {
  @override
  Stream<ResultHolder<Result, ErrorModel>> call(Param param);
}
