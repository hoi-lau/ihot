import 'dart:typed_data';

import 'package:app/utils/EvenBus.dart';
import 'package:flutter/material.dart';

class PageImage {
  PageImage({required this.imgData, required this.globalKey});

  GlobalKey globalKey;
  Uint8List imgData;
}

class AppOverview extends StatefulWidget {
  const AppOverview({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppOverviewState();
  }
}

class _AppOverviewState extends State<AppOverview> {
  List<PageImage> pageImages = [];

  @override
  void initState() {
    super.initState();
    bus.on('overview-change', (arg) {
      print(arg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: pageImages.map((e) => Image.memory(e.imgData)).toList(),
      ),
    );
  }
}

// class AppOverview extends StatelessWidget {
//   const AppOverview({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> children = [];
//     for (var i = 0; i < pages.length - 1; i++) {
//       children.add(AppCard(
//         key: Key('$i'),
//         child: pages[i],
//       ));
//     }
//     return SafeArea(
//       child: Row(
//         children: children,
//       ),
//     );
//   }
// }

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
    // List<Widget> children = appContainerKeys.map((e) => null)
    return Text('data');
  }
}
