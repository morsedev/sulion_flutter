import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/feature/product_list/view_model/product_list_view_model.dart';

abstract class ProductListDependency extends Dependency {
  ProductListDependency({required this.viewModel});
  final ProductListViewModel viewModel;
}

class DefaultProductListDependency implements ProductListDependency {
  DefaultProductListDependency({required this.viewModel});
  @override
  final ProductListViewModel viewModel;
}
