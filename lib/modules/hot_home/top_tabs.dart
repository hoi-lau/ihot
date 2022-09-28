import 'package:flutter/cupertino.dart';

class TopTabs extends StatefulWidget {
  const TopTabs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TopTabsState();
  }
}

class _TopTabsState extends State<TopTabs> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Text('_TopTabsState');
  }
}
