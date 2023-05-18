import 'package:flutter/material.dart';
import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/di/di_widget.dart';
import 'package:sulion_app/src/di/login/login_di.dart';
import 'package:sulion_app/src/di/product_list/product_list_di.dart';
import 'package:sulion_app/src/feature/product_list/page/product_list_page.dart';
import 'package:sulion_app/src/feature/session/page/login_page.dart';
import 'package:sulion_app/src/plugs/login/login_plug.dart';
import 'package:sulion_app/src/plugs/plug.dart';
import 'package:sulion_app/src/plugs/product_list/product_list_plug.dart';
import 'package:sulion_app/src/shared/base/page/base_page.dart';
import 'package:sulion_app/src/shared/theme/theme.dart';

// Challenge: conectar las dependencias de App (ViewModel, UseCase, Repository, DiWidget, Plug), para
// poder llamar al método bootstrap, cuando haga el primer refresh token debería
// lanzar un error en consola (Unimplemented), opcionalmente capturar el error y mostar
// algo por consola.

class App extends BasePage {
  const App(
      {super.key,
      this.loginPlug = const LoginPlug(),
      this.productListPlug = const ProductListPlug()});

  final Plug<LoginPage, LoginDependency> loginPlug;
  final Plug<ProductListPage, ProductListDependency> productListPlug;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(context),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => LoginDiWidget(navigator: Navigator.of(context)),
        'product_list': (context) => DiWidget(
              dependency: DefaultProductListDependency(),
              plug: productListPlug,
            )
      },
    );
  }
}
