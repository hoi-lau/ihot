import 'dart:io';

import 'package:app/modules/Home/Desktop.dart';
import 'package:app/modules/Home/Mobile.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid || Platform.isIOS) {
      return const MobileHome();
    }
    return const DesktopHome();
  }
}
