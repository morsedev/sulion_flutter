import 'package:sulion_app/src/core/product_list/data/repository/product_list_repository_impl.dart';
import 'package:sulion_app/src/core/product_list/domain/use_case/product_list_use_case_impl.dart';
import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/feature/product_list/view_model/product_list_view_model.dart';
import 'package:sulion_app/src/shared/infra/client.dart';

abstract class ProductListDependency extends Dependency {
  ProductListDependency();
  ProductListViewModel get viewModel;
}

class DefaultProductListDependency implements ProductListDependency {
  DefaultProductListDependency();
  @override
  final ProductListViewModel viewModel = ProductListViewModel(
    ProductListUseCaseImpl(
      ProductListRepositoryImpl(
        ClientImpl(),
      ),
    ),
  );
}
