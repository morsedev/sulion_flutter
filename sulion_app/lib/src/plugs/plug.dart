import 'package:sulion_app/src/di/di.dart';
import 'package:sulion_app/src/shared/base/page/base_page.dart';

abstract class Plug<W extends BasePage, Dep extends Dependency> {
  W call(Dep dependency);
}
