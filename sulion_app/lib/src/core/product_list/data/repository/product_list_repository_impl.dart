import 'dart:convert';

import 'package:sulion_app/src/core/product_list/domain/entity/product_entity.dart';
import 'package:sulion_app/src/core/product_list/domain/repository/product_list_repository.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/infra/client.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  const ProductListRepositoryImpl(this._datasource);

  final Client _datasource;

  @override
  Future<ResultHolder<List<ProductEntity>, ErrorModel>> getProducts(
      String? id) async {
    var respuesta = await _datasource.products(id);
    if (respuesta.statusCode == 200) {
      List<dynamic> listBody = jsonDecode(respuesta.body);
      List<ProductEntity> productList = listBody
          .map((mapa) => ProductEntity.fromJson(mapa as Map<String, dynamic>))
          .toList();
      return ResultHolder.success(productList);
    }

    return ResultHolder.fail(const ErrorModel(
        code: 'Falló',
        message: 'Ocurrió un fallo al obtener el listado de productos'));
  }
}
