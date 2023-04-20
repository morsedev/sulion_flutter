import 'package:flutter/material.dart';
import 'package:sulion_app/src/shared/theme/theme.dart';

class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer._({required this.type});

  factory VerticalSpacer.regular() => const VerticalSpacer._(
        type: SpaceType.regular,
      );
  factory VerticalSpacer.medium() => const VerticalSpacer._(
        type: SpaceType.medium,
      );
  final SpaceType type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _getSpacerHeight(context),
    );
  }

  double _getSpacerHeight(BuildContext context) {
    switch (type) {
      case SpaceType.regular:
        return Theme.of(context).regularDimension;
      case SpaceType.medium:
        return Theme.of(context).mediumDimension;
    }
  }
}

enum SpaceType {
  regular,
  medium;
}

class HorizontalSpacer extends StatelessWidget {
  const HorizontalSpacer._({required this.type});

  factory HorizontalSpacer.regular() => const HorizontalSpacer._(
        type: SpaceType.regular,
      );
  factory HorizontalSpacer.medium() => const HorizontalSpacer._(
        type: SpaceType.medium,
      );
  final SpaceType type;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _getSpacerHeight(context),
    );
  }

  double _getSpacerHeight(BuildContext context) {
    switch (type) {
      case SpaceType.regular:
        return Theme.of(context).regularDimension;
      case SpaceType.medium:
        return Theme.of(context).mediumDimension;
    }
  }
}
