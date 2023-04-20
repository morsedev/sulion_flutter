import 'package:flutter/material.dart';
import 'package:sulion_app/src/di/di.dart';

import '../shared/base/page/base_page.dart';
import '../plugs/plug.dart';

class DiWidget<W extends BasePage, Dep extends Dependency>
    extends StatelessWidget {
  const DiWidget({
    super.key,
    required this.dependency,
    required this.plug,
  });
  final Dep dependency;
  final Plug<W, Dep> plug;

  @override
  Widget build(BuildContext context) => plug(dependency);
}
