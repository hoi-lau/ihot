import 'package:flutter/material.dart';

class Base64Page extends StatefulWidget {
  const Base64Page({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Base64PageState();
  }
}

class _Base64PageState extends State<Base64Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Text('data'),
            )
          ],
        ),
      ),
    );
  }
}
