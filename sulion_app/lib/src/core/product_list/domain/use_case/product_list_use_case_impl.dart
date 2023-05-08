import 'package:sulion_app/src/core/product_list/domain/entity/product_entity.dart';
import 'package:sulion_app/src/core/product_list/domain/repository/product_list_repository.dart';
import 'package:sulion_app/src/core/product_list/domain/use_case/product_list_use_case.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';
import 'package:sulion_app/src/shared/base/error/error_model.dart';

class ProductListUseCaseImpl implements ProductListUseCase {
  const ProductListUseCaseImpl(this._repository);

  final ProductListRepository _repository;

  @override
  Future<ResultHolder<List<ProductEntity>, ErrorModel>> call(String? param) {
    return _repository.getProducts(param);
  }
}
