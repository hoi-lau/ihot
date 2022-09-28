import 'package:flutter/cupertino.dart';

class WeiboHot extends StatefulWidget {
  const WeiboHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeiboHotState();
  }
}

class _WeiboHotState extends State<WeiboHot> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Text('_WeiboHotState');
  }
}
