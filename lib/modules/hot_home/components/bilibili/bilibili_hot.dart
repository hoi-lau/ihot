import 'package:flutter/material.dart';

class BilibiliHot extends StatefulWidget {
  const BilibiliHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BilibiliHotState();
  }
}

class _BilibiliHotState extends State<BilibiliHot>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    print('BilibiliHot build');
    return Container(
      child: Text('_BilibiliHotState'),
    );
  }
}
