import 'package:app/constant/Constant.dart';
import 'package:app/modules/hot_home/components/anquanke.dart';
import 'package:app/modules/hot_home/components/bilibili.dart';
import 'package:app/modules/hot_home/components/github.dart';
import 'package:app/modules/hot_home/components/hupu.dart';
import 'package:app/modules/hot_home/components/juejin.dart';
import 'package:app/modules/hot_home/components/v2ex.dart';
import 'package:app/modules/hot_home/components/weibo.dart';
import 'package:app/modules/hot_home/components/zhihu.dart';
import 'package:flutter/material.dart';
import 'dart:io';

var httpClient = HttpClient();

class HotHome extends StatefulWidget {
  const HotHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HotHomeState();
  }
}

class HotItem {
  const HotItem(
      {required this.title, required this.avatar, required this.content});

  final String title;
  final AssetImage avatar;
  final Widget content;
}

class _HotHomeState extends State<HotHome> {
  int activeIndex = 0;

  final List<HotItem> hotList = [
    const HotItem(
        title: '虎扑',
        avatar: AssetImage('${Constant.ASSETS_IMG}hupu.png'),
        content: HupuHot()),
    const HotItem(
        title: 'github',
        avatar: AssetImage('${Constant.ASSETS_IMG}github.png'),
        content: GithubHot()),
    const HotItem(
        title: 'v2ex',
        avatar: AssetImage('${Constant.ASSETS_IMG}v2ex.png'),
        content: V2exHot()),
    const HotItem(
        title: '知乎',
        avatar: AssetImage('${Constant.ASSETS_IMG}zhihu.png'),
        content: ZhihuHot()),
    const HotItem(
        title: 'bilibili',
        avatar: AssetImage('${Constant.ASSETS_IMG}bilibili.png'),
        content: BilibiliHot()),
    const HotItem(
        title: '安全客',
        avatar: AssetImage('${Constant.ASSETS_IMG}anquanke.png'),
        content: AnquankeHot()),
    const HotItem(
        title: '微博',
        avatar: AssetImage('${Constant.ASSETS_IMG}weibo.png'),
        content: WeiboHot()),
    const HotItem(
        title: '掘金',
        avatar: AssetImage('${Constant.ASSETS_IMG}juejin.png'),
        content: JuejinHot()),
  ];

  @override
  Widget build(BuildContext context) {
    final tabs = hotList
        .map(
          (e) => Tab(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image(
                  image: e.avatar,
                  width: 18,
                  height: 18,
                ),
                Text(
                  e.title,
                )
              ],
            ),
          ),
        )
        .toList();
    return SafeArea(
      child: DefaultTabController(
        initialIndex: activeIndex,
        length: hotList.length,
        child: Scaffold(
          backgroundColor: Colors.white70,
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 60),
              child: TabBar(
                isScrollable: true,
                tabs: tabs,
                padding: const EdgeInsets.only(left: 8, right: 8),
                labelColor: Colors.black,
                indicatorColor: Colors.blue,
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            child: TabBarView(children: hotList.map((e) => e.content).toList()),
          ),
        ),
      ),
    );
  }
}
