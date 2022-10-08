import 'package:flutter/material.dart';

class BilibiliRank extends StatefulWidget {
  const BilibiliRank({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BilibiliRankState();
  }
}

class _BilibiliRankState extends State<BilibiliRank>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Container(
      child: Text('_BilibiliRankState'),
    );
  }
}
