library sulion_theme;

import 'package:flutter/material.dart';

part 'theme_extension.dart';
part 'light_theme.dart';
part 'dark_theme.dart';

theme(BuildContext context) => Theme.of(context).copyWith(
      appBarTheme: appBarTheme,
    );
