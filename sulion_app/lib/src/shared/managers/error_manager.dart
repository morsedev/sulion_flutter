import 'dart:async';

import 'package:sulion_app/src/shared/base/error/error_model.dart';

class ErrorManager {
  static final ErrorManager _instance = ErrorManager._internal();

  ErrorManager._internal();
  factory ErrorManager() => _instance;

  final StreamController<ErrorModel> _streamController = StreamController();
  Stream<ErrorModel> get errorStream {
    return _streamController.stream;
  }

  notify(ErrorModel error) {
    _streamController.add(error);
  }
}
