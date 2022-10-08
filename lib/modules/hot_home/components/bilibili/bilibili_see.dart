import 'package:flutter/material.dart';

class BilibiliSee extends StatefulWidget {
  const BilibiliSee({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BilibiliSeeState();
  }
}

class _BilibiliSeeState extends State<BilibiliSee>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      child: Text('_BilibiliSeeState'),
    );
  }
}
