import 'package:flutter/material.dart';

import 'data.dart';

class MobileAppContainer extends StatefulWidget {
  const MobileAppContainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MobileAppContainerState();
  }
}

class _MobileAppContainerState extends State<MobileAppContainer> {
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    print('initState');
  }

  Widget _getPagesWidget(int index) {
    return Offstage(
      offstage: _selectIndex != index,
      child: TickerMode(
        enabled: _selectIndex == index,
        child: pages[index],
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
          ],
        ),
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.6),
        bottomNavigationBar: BottomNavigationBar(
          items: itemList,
          // backgroundColor: const Color.fromRGBO(241, 241, 248, 1),
          onTap: (int index) {
            ///这里根据点击的index来显示，非index的page均隐藏
            setState(() {
              _selectIndex = index;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 24,
          currentIndex: _selectIndex,
        ));
  }
}
