import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/modules/hot_home/components/bilibili/bilibili_rank.dart';
import 'package:app/modules/hot_home/components/bilibili/bilibili_see.dart';
import 'package:app/modules/hot_home/components/bilibili/bilibili_week.dart';
import 'package:flutter/material.dart';

class BilibiliHot extends StatefulWidget {
  const BilibiliHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BilibiliHotState();
  }
}

class _BilibiliHotState extends State<BilibiliHot> {
  int activeIndex = 0;

  final List<String> tabList = ['综合热门', '排行榜', '每周必看', '入站必刷'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: activeIndex,
      length: tabList.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
            unselectedLabelColor: Colors.redAccent,
            labelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.blue,
            indicator: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Colors.redAccent, Colors.orangeAccent]),
              borderRadius: BorderRadius.circular(20),
              color: Colors.redAccent,
            ),
            onTap: (int i) async {},
            tabs: List.generate(
              tabList.length,
              (index) => Tab(
                height: 28,
                key: Key(tabList[index]),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(tabList[index]),
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            Container(),
            Container(),
            Container(),
            // Shimmer(
            //   key: Key('0'),
            //   child: BilibiliHot(),
            // ),
            // Shimmer(
            //   key: Key('1'),
            //   child: BilibiliRank(),
            // ),
            // Shimmer(
            //   key: Key('2'),
            //   child: BilibiliWeek(),
            // ),
            // Shimmer(
            //   key: Key('3'),
            //   child: BilibiliSee(),
            // ),
          ],
        ),
      ),
    );
  }
}
