import 'package:flutter/material.dart';
import 'package:sulion_app/src/core/product_list/data/repository/product_list_repository_impl.dart';
import 'package:sulion_app/src/core/product_list/domain/repository/product_list_repository.dart';
import 'package:sulion_app/src/core/product_list/domain/use_case/product_list_use_case.dart';
import 'package:sulion_app/src/core/product_list/domain/use_case/product_list_use_case_impl.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case_impl.dart';
import 'package:sulion_app/src/di/di_widget.dart';
import 'package:sulion_app/src/di/login/login_di.dart';
import 'package:sulion_app/src/di/product_list/product_list_di.dart';
import 'package:sulion_app/src/feature/product_detail/page/product_detail_page.dart';
import 'package:sulion_app/src/feature/product_list/page/product_list_page.dart';
import 'package:sulion_app/src/feature/product_list/view_model/product_list_view_model.dart';
import 'package:sulion_app/src/feature/session/page/login_page.dart';
import 'package:sulion_app/src/feature/session/view_model/login_view_model.dart';
import 'package:sulion_app/src/core/session/data/repository/session_repository.dart';
import 'package:sulion_app/src/plugs/login/login_plug.dart';
import 'package:sulion_app/src/plugs/product_list/product_list_plug.dart';
import 'package:sulion_app/src/shared/theme/theme.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/plugs/plug.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Client datasource = ClientImpl();
    SessionRepository loginRepository = SessionRepositoryImpl(datasource);
    Plug<LoginPage, LoginDependency> loginPlug = LoginPlug();
    LoginUseCase loginUseCase = LoginUseCaseImpl(loginRepository);

    ProductListRepository productRepository =
        ProductListRepositoryImpl(datasource);
    Plug<ProductListPage, ProductListDependency> productListPlug =
        ProductListPlug();
    ProductListUseCase productListUseCase =
        ProductListUseCaseImpl(productRepository);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(context),
      routes: <String, WidgetBuilder>{
        '/': (context) => DiWidget<LoginPage, LoginDependency>(
              dependency: DefaultLoginDependency(
                viewModel: LoginViewModel(
                  loginUseCase: loginUseCase,
                  navigator: Navigator.of(context),
                ),
              ),
              plug: loginPlug,
            ),
        'product_list': (context) =>
            DiWidget<ProductListPage, ProductListDependency>(
              dependency: DefaultProductListDependency(
                viewModel: ProductListViewModel(productListUseCase),
              ),
              plug: productListPlug,
            )
      },
    );
  }
}
