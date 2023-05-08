import 'package:sulion_app/src/core/product_list/domain/entity/product_entity.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class ProductListRepository {
  Future<ResultHolder<List<ProductEntity>, ErrorModel>> getProducts(String? id);
}
