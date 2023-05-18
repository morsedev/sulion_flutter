import 'dart:async';

import 'package:sulion_app/src/core/product_list/domain/use_case/product_list_use_case.dart';
import 'package:sulion_app/src/core/shared/data/model/product_model.dart';
import 'package:sulion_app/src/shared/base/result/result_holder.dart';

class ProductListViewModel {
  ProductListViewModel(this._productListUseCase);
  final ProductListUseCase _productListUseCase;
  final StreamController<List<Product>> _controller = StreamController();
  Stream<List<Product>> get state => _controller.stream;
  String? lastId = 'duplo';

  getProducts() async {
    var response = await _productListUseCase(lastId);
    switch (response.result) {
      case Result.succeed:
        var products = response.successData
            ?.map((entity) => Product(
                name: entity.id,
                description: entity.description,
                image: entity.image))
            .toList();
        if (products != null && products.isNotEmpty) {
          lastId = products.last.name;
          _controller.add(products);
        }
        break;
      case Result.failed:
        // TODO: Handle this case.
        break;
    }
  }
}
