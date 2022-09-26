import 'package:app/routes/index.dart';
import 'package:flutter/material.dart';

class AppOverview extends StatelessWidget {
  const AppOverview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (var i = 0; i < pages.length; i++) {
      children.add(AppCard(
        key: Key('$i'),
        child: pages[i],
      ));
    }
    return SafeArea(
      child: Row(
        children: children,
      ),
    );
  }
}

class AppCard extends StatefulWidget {
  const AppCard({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _AppCardState();
  }
}

class _AppCardState extends State<AppCard> {
  late Widget pageImage;

  @override
  void initState() {
    super.initState();
    initPageImage();
  }

  Future<void> initPageImage() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: widget.child,
    // );
    return Text('data');
  }
}
