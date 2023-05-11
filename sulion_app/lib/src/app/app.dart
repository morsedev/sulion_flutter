import 'package:flutter/material.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case_impl.dart';
import 'package:sulion_app/src/di/di_widget.dart';
import 'package:sulion_app/src/di/login/login_di.dart';
import 'package:sulion_app/src/di/product_list/product_list_di.dart';
import 'package:sulion_app/src/feature/product_list/page/product_list_page.dart';
import 'package:sulion_app/src/feature/session/page/login_page.dart';
import 'package:sulion_app/src/feature/session/view_model/login_view_model.dart';
import 'package:sulion_app/src/core/session/data/repository/session_repository.dart';
import 'package:sulion_app/src/plugs/login/login_plug.dart';
import 'package:sulion_app/src/plugs/product_list/product_list_plug.dart';
import 'package:sulion_app/src/shared/infra/local_datasource.dart';
import 'package:sulion_app/src/shared/theme/theme.dart';
import 'package:sulion_app/src/shared/infra/client.dart';
import 'package:sulion_app/src/plugs/plug.dart';

// Challenge: conectar las dependencias de App (ViewModel, UseCase, Repository, DiWidget, Plug), para
// poder llamar al método bootstrap, cuando haga el primer refresh token debería
// lanzar un error en consola (Unimplemented), opcionalmente capturar el error y mostar
// algo por consola.

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Client remoteDatasource = ClientImpl();
    LocalDatasource localDatasource = LocalDatasourceImpl();
    SessionRepository loginRepository =
        SessionRepositoryImpl(remoteDatasource, localDatasource);
    Plug<LoginPage, LoginDependency> loginPlug = LoginPlug();
    LoginUseCase loginUseCase = LoginUseCaseImpl(loginRepository);

    Plug<ProductListPage, ProductListDependency> productListPlug =
        ProductListPlug();

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
              dependency: DefaultProductListDependency(),
              plug: productListPlug,
            )
      },
    );
  }
}
