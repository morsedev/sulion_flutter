import 'package:http/http.dart' hide Client;
import 'package:sulion_app/src/core/session/data/model/login_request_model.dart';
import 'package:sulion_app/src/core/session/domain/entity/login_entity.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

class SessionRepositoryImpl implements SessionRepository {
  const SessionRepositoryImpl(
    this._datasource,
  );

  @override
  final Client _datasource;

  @override
  Future<ResultHolder<bool, ErrorModel>> login(LoginEntity entity) async {
    final request = LoginRequestModel.fromEntity(entity);

    var respuesta = await _datasource.login(request.toJson());
    if (respuesta.statusCode == 200) {
      return ResultHolder<bool, ErrorModel>.success(true);
    }
    return ResultHolder<bool, ErrorModel>.fail(
      const ErrorModel(
        code: 'fallo',
        message: 'Algo ha fallado',
      ),
    );
  }

  Future<String> getUser() {
    // Se llama a la base de datos... No sabemos cuanto tarda
    return Future(() => 'Juanito');
  }
}
