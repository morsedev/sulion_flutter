import 'package:sulion_app/src/app/app.dart';
import 'package:sulion_app/src/di/app/app_di.dart';

import '../plug.dart';

class AppPlug implements Plug<App, AppDependency> {
  @override
  App call(AppDependency dependency) {
    return const App();
  }
}
