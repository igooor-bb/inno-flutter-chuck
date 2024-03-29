import 'package:chuck/chuck_theme.dart';
import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ChuckTheme.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chuck Jokes',
      theme: theme,
      home: const Home(),
    );
  }
}
