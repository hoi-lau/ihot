import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/modules/hot_home/components/hupu/hupu_list.dart';
import 'package:app/modules/hot_home/components/hupu/model.dart';
import 'package:app/modules/hot_home/hot_home.dart';
import 'package:app/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HupuHot extends StatefulWidget {
  const HupuHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HupuHotState();
  }
}

class _HupuHotState extends State<HupuHot> with AutomaticKeepAliveClientMixin {
  int activeIndex = 0;

  bool _loading = true;

  final int maxRows = 20;

  List<dynamic> rankHotList = [];

  List<List<PostResp>> allHotList = [[], [], [], [], [], [], [], []];

  final List<Tag> tagsList = [
    Tag(title: '话题榜', tagId: -1),
    Tag(title: '热帖榜', tagId: 0),
    Tag(title: '步行街', tagId: 1),
    Tag(title: '篮球', tagId: 80000),
    Tag(title: '数码', tagId: 6),
    Tag(title: '英雄联盟', tagId: 70001),
    Tag(title: '影视娱乐', tagId: 5),
    Tag(title: '游戏', tagId: 70003),
    Tag(title: '足球', tagId: 90000),
  ];

  @override
  void initState() {
    super.initState();
    initRankHotList();
  }

  Future<void> initRankHotList() async {
    setState(() {
      _loading = true;
    });
    var request = await httpClient.getUrl(Uri.parse(
        'https://bbs.mobileapi.hupu.com/3/7.5.56/bbsallapi/tag/v1/heatTag'));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      rankHotList = [...data['data']['content']];
      _loading = false;
      setState(() {});
    } else {
      // error deal
    }
  }

  Future<void> initPostList(int index) async {
    if (allHotList[index - 1].isNotEmpty) {
      return;
    }
    setState(() {
      _loading = true;
    });
    var timestamp = '${DateTime.now().millisecondsSinceEpoch}';
    var url =
        'https://games.mobileapi.hupu.com/3/7.5.56/hotRank/?category=${tagsList[index].tagId}&cid=102750844&crt=${timestamp.substring(0, 10)}';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      // List<> list =  data['result']['listV2'].map();
      List<PostResp> list = data['result']['listV2']
          .map<PostResp>(
            (e) => PostResp(
              schemaUrl: e['schemaUrl'],
              thread: PostHeader(
                  title: e['thread']['title'],
                  topic_name: e['thread']['topic_name'],
                  video: e['thread']['video'] != null
                      ? VideoBody(img: e['thread']['video']['img'])
                      : null,
                  share: UrlBody(
                      url: e['thread']['share'] != null
                          ? e['thread']['share']['url']
                          : ''),
                  pics: e['thread']['pics'] != null
                      ? e['thread']['pics'].map<UrlBody>((ele) {
                          return UrlBody(url: ele['url']);
                        }).toList()
                      : []),
            ),
          )
          .toList();
      setState(() {
        allHotList[index - 1] = [...list];
        _loading = false;
      });
    } else {
      // error deal
    }
  }

  Widget _buildRankListItem(int index) {
    return ShimmerLoading(
      key: Key('$index'),
      isLoading: _loading,
      child: RankHotListItem(
        loading: _loading,
        child: rankHotList.isNotEmpty
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(240, 241, 245, 1),
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 8, right: 8),
                child: GestureDetector(
                  onTap: () async {
                    final Uri _url = Uri.parse(
                        'huputiyu://bbs/topicTag?tagId=${rankHotList[index]['tagId']}&clt=d1fa2b2a-3fb6-0f01-0b1f-f1df0242f9f5&r=kqappshare_news');
                    if (!await launchUrl(_url)) {
                      // throw 'Could not launch $_url';
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: ClipPath(
                          clipper: ClipperPath(),
                          child: Container(
                            color: index < 3
                                ? const Color.fromRGBO(253, 236, 237, 1)
                                : const Color.fromRGBO(199, 203, 213, 1),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: index < 3
                                        ? const Color.fromRGBO(234, 14, 32, 1)
                                        : const Color.fromRGBO(36, 38, 43, 1)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rankHotList[index]['tagName'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 4),
                                child: Text(
                                  '${thousandSeparate(rankHotList[index]['heat'])} 热度',
                                  style: const TextStyle(
                                      color: Color.fromRGBO(133, 144, 166, 1),
                                      fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Image.network(
                        '${rankHotList[index]['icon']}',
                        width: 32,
                        height: 32,
                        // loadingBuilder: (BuildContext context, Widget wg,
                        //     ImageChunkEvent? e) {
                        //   return Image.asset('name');
                        // },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  List<Widget> _buildList() {
    List<Widget> children = [
      Shimmer(
        key: const Key('0'),
        child: ListView(
          physics: _loading ? const NeverScrollableScrollPhysics() : null,
          children:
              List.generate(maxRows, (index) => _buildRankListItem(index)),
        ),
      ),
    ];
    for (int i = 1; i < tagsList.length; i++) {
      children.add(
        Shimmer(
          key: Key('$i'),
          child: PostHotList(
            tagId: tagsList[i].tagId,
          ),
        ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: activeIndex,
      length: tagsList.length,
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
            tabs: tagsList
                .map(
                  (e) => Tab(
                    height: 28,
                    key: Key(e.title),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(e.title),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(children: _buildList()),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
