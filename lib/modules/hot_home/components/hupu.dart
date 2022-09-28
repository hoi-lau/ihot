import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HupuHot extends StatefulWidget {
  const HupuHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HupuHotState();
  }
}

class _HupuHotState extends State<HupuHot> {
  int activeIndex = 0;

  bool loading = true;

  final int maxRows = 20;

  //
  // Widget loadingContent() {
  //   return ;
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: loading
            ? List.generate(maxRows, (index) => Text('key: ,')).toList()
            : [],
      ),
    );
  }
}
