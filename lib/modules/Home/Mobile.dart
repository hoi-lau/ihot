import 'package:flutter/material.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MobileHomeState();
  }
}

class _MobileHomeState extends State<MobileHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: const BoxDecoration(
          border: Border(
        left: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
        right: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
        top: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
        bottom: BorderSide(color: Color.fromRGBO(229, 229, 229, 1), width: 1),
      )),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFDFDFDF)),
            left: BorderSide(color: Color(0xFFDFDFDF)),
            right: BorderSide(color: Color(0xFF7F7F7F)),
            bottom: BorderSide(color: Color(0xFF7F7F7F)),
          ),
          color: Color(0xFFBFBFBF),
        ),
        child: const Text('OK', textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF000000))),
      ),
    )));
  }
}
