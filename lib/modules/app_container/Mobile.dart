import 'package:app/modules/app_overview/index.dart';
import 'package:app/utils/EvenBus.dart';
import 'package:app/utils/index.dart';
import 'package:flutter/material.dart';

import '../../config/AppTheme.dart';
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
    List.generate(pages.length - 1, (e) => GlobalKey());

class _MobileAppContainerState extends State<MobileAppContainer> {
  int _selectIndex = 1;

  @override
  void initState() {
    super.initState();
    bus.on('page-change', (arg) async {
      // var res = await widgetToImage(appContainerKeys[_selectIndex]);

      setState(() {
        _selectIndex = arg;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration.zero, () async {
        List<PageImage> pageImages = [];
        for (var i = 0; i < appContainerKeys.length; i++) {
          var value = await widgetToImage(appContainerKeys[i]);
          pageImages
              .add(PageImage(globalKey: appContainerKeys[i], imgData: value));
        }
        bus.emit('overview-change', pageImages);
      });
    });
  }

  _getPagesWidget(int index) {
    // widgetToImage(appContainerKeys[_selectIndex]).then((value) => null);
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        // child: pages[index],
        child: index == 0
            ? pages[index]
            : RepaintBoundary(
                key: appContainerKeys[index - 1],
                child: pages[index],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _getPagesWidget(0),
          _getPagesWidget(1),
          _getPagesWidget(2),
        ],
      ),
      // body: widget.child,
      backgroundColor: appTheme.homeTheme.getBgColor(),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: itemList,
      //   onTap: (int index) {
      //     ///这里根据点击的index来显示，非index的page均隐藏
      //     setState(() {
      //       _selectIndex = index;
      //     });
      //   },
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   iconSize: 24,
      //   currentIndex: _selectIndex,
      // ),
    );
  }
}
