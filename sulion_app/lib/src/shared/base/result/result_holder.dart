enum Result {
  succeed,
  failed;
}

class ResultHolder<SuccessData, ErrorData> {
  late final Result result;
  late final SuccessData? successData;
  late final ErrorData? errorData;

  ResultHolder._internal({
    required this.result,
    this.successData,
    this.errorData,
  });

  factory ResultHolder.success(SuccessData data) {
    return ResultHolder._internal(
      result: Result.succeed,
      successData: data,
    );
  }

  factory ResultHolder.fail(ErrorData data) {
    return ResultHolder._internal(
      result: Result.failed,
      errorData: data,
    );
  }
}
