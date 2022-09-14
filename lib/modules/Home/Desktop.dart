import 'package:flutter/material.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DesktopHomeState();
  }
}

class _DesktopHomeState extends State<DesktopHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // backgroundColor: Color.fromRGBO(241, 241, 248, 1),
        body: SafeArea(
            child: Text('home', style: TextStyle(color: Colors.black38))));
  }
}
