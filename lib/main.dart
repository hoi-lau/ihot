import 'dart:io';

import 'package:app/modules/app_container/index.dart';
import 'package:flutter/material.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
  // HttpOverrides.global = _HttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const AppContainer();
  }
}

class _HttpOverrides extends HttpOverrides {
  List<String> needProxy = [];

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }

  @override
  String findProxyFromEnvironment(_, __) {
    if (needProxy.any((element) => _.origin.contains(element))) {
      print('proxy');
      return 'PROXY 192.168.3.145:8899;'; // IP address of your proxy
    }
    print('DIRECT');
    return 'DIRECT';
  }
}
