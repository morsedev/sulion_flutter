import 'package:sulion_app/src/core/product_list/domain/entity/product_entity.dart';
import 'package:sulion_app/src/core/shared/domain/use_case/base_use_case.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

abstract class ProductListUseCase
    extends BaseUseCase<List<ProductEntity>, String> {
  @override
  Future<ResultHolder<List<ProductEntity>, ErrorModel>> call(String? param);
}
