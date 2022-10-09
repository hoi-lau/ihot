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
  void initState() {
    super.initState();
    // https://api.bilibili.com/x/web-interface/popular/precious?page_size=20&page=1
  }

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
