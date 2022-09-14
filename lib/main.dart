import 'package:flutter/material.dart';

import 'modules/AppContainer/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'faire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.blueAccent,
      ),
      home: const AppContainer(),
    );
  }
}
