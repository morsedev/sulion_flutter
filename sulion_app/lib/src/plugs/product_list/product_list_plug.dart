import 'package:sulion_app/src/di/product_list/product_list_di.dart';
import 'package:sulion_app/src/feature/product_list/page/product_list_page.dart';
import 'package:sulion_app/src/plugs/plug.dart';

class ProductListPlug implements Plug<ProductListPage, ProductListDependency> {
  @override
  ProductListPage call(ProductListDependency dependency) {
    return ProductListPage(
      getProducts: dependency.viewModel.getProducts,
      state: dependency.viewModel.state,
    );
  }
}
