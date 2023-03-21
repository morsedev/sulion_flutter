import 'package:flutter/material.dart';
import 'package:sulion/pages/pages.dart';
import 'package:sulion/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(context),
      home: const LoginPage(),
    );
  }
}
