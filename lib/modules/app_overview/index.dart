import 'dart:typed_data';

import 'package:app/constant/Constant.dart';
import 'package:app/routes/index.dart';
import 'package:app/utils/EvenBus.dart';
import 'package:flutter/cupertino.dart';
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

List<PageImage> pageImages = [];

class _AppOverviewState extends State<AppOverview> {
  @override
  void initState() {
    super.initState();
  }

  void handleActivePageChange(int index) {
    // bus.emit('page-change', index + 1);
    MyRouter.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> reviewList = [];
    // for (var i = 0; i < pageImages.length; i++) {
    //   reviewList.add(
    //     FractionallySizedBox(
    //       key: Key('$i'),
    //       widthFactor: .5,
    //       child: Container(
    //         decoration: BoxDecoration(
    //           border: Border.all(
    //             color: Colors.grey.withOpacity(0.2), // 边框颜色
    //             width: 1, // 边框宽度
    //           ),
    //           color: Colors.white, // 底色
    //           boxShadow: [
    //             BoxShadow(
    //               blurRadius: 10, //阴影范围
    //               spreadRadius: 0.1, //阴影浓度
    //               color: Colors.grey.withOpacity(0.2), //阴影颜色
    //             ),
    //           ],
    //           borderRadius: BorderRadius.circular(10),
    //         ),
    //         margin: const EdgeInsets.all(20),
    //         child: ClipRRect(
    //           borderRadius: const BorderRadius.all(Radius.circular(10)),
    //           child: CupertinoButton(
    //             onPressed: () {
    //               handleActivePageChange(i);
    //             },
    //             padding: const EdgeInsets.all(0),
    //             child: Hero(
    //               tag: outsideHero[i],
    //               child: Image.memory(
    //                 pageImages[i].imgData,
    //                 // height: 300,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Hero(
            tag: 'home-page',
            child: Image.asset('${Constant.ASSETS_IMG}favicon.png'),
          ),
          // child: Wrap(
          //   children: reviewList,
          // ),
        ),
      ),
    );
  }
}
