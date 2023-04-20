import 'package:flutter/material.dart';
import 'package:sulion_app/src/core/session/domain/repository/session_repository.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case.dart';
import 'package:sulion_app/src/core/session/domain/use_case/login_use_case_impl.dart';
import 'package:sulion_app/src/di/di_widget.dart';
import 'package:sulion_app/src/di/login/login_di.dart';
import 'package:sulion_app/src/feature/session/page/login_page.dart';
import 'package:sulion_app/src/feature/session/view_model/login_view_model.dart';
import 'package:sulion_app/src/core/session/data/repository/session_repository.dart';
import 'package:sulion_app/src/plugs/login/login_plug.dart';
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
    Plug<LoginPage, LoginDependency> plug = LoginPlug();
    LoginUseCase loginUseCase = LoginUseCaseImpl(loginRepository);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(context),
      routes: <String, WidgetBuilder>{
        '/': (context) => DiWidget<LoginPage, LoginDependency>(
              dependency: DefaultLoginDependency(
                  viewModel: LoginViewModel(
                loginUseCase: loginUseCase,
                navigator: Navigator.of(context),
              )),
              plug: plug,
            )
      },
    );
  }
}
