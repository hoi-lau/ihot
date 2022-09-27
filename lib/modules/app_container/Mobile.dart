import 'package:flutter/material.dart';
import 'data.dart';

class MobileAppContainer extends StatefulWidget {
  const MobileAppContainer({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<StatefulWidget> createState() {
    return _MobileAppContainerState();
  }
}

List<GlobalKey> appContainerKeys =
    List.generate(outsidePages.length - 1, (e) => GlobalKey());

class _MobileAppContainerState extends State<MobileAppContainer> {
  @override
  void initState() {
    super.initState();
    // if (widget.child != null) return;
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   Future.delayed(const Duration(milliseconds: 100), () async {
    //     List<PageImage> list = [];
    //     print('setState start');
    //     for (var i = 0; i < appContainerKeys.length; i++) {
    //       var value = await widgetToImage(appContainerKeys[i]);
    //       list.add(PageImage(globalKey: appContainerKeys[i], imgData: value));
    //     }
    //     pageImages = [...list];
    //     bus.emit('overview-change', pageImages);
    //     setState(() {
    //       offstage = true;
    //     });
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: widget.child);
  }
}
