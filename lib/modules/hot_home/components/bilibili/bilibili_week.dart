import 'package:flutter/material.dart';

class BilibiliWeek extends StatefulWidget {
  const BilibiliWeek({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BilibiliWeekState();
  }
}

class _BilibiliWeekState extends State<BilibiliWeek>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      child: Text('_BilibiliWeekState'),
    );
  }
}
