import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
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

class Tag {
  Tag({required this.title, required this.tagId});

  String title;
  int tagId;
}

class Pics {
  Pics({required this.url});

  String url;
}

class VideoBody {
  VideoBody({required this.img});

  String img;
}

class PostHeader {
  PostHeader(
      {required this.title, required this.topic_name, this.pics, this.video});

  String title;
  String topic_name;
  List<Pics>? pics;
  VideoBody? video;
}

class PostResp {
  PostResp({required this.schemaUrl, required this.thread});

  String schemaUrl;
  PostHeader thread;
}

/// https://bbs.mobileapi.hupu.com/3/7.5.56/bbsallapi/tag/v1/heatTag
/// https://games.mobileapi.hupu.com/3/7.5.56/hotRank/?sign=571179e0844a9606eec015c6a0e8482c&category=70003&clientId=102750844&deviceId=BtCkC6CGNpJxt2S1GVXjY7S6GRVtxgQpL%2BIeC8RNz16fNWfJaL0iF7zo4iJrVkJctPhAnY3FKiNQ9e%2BRif4%2B05g%3D%3D&cid=102750844&puid=96756348&token=NDYxNzY2MTg%3D%7CMTY1MzI5OTU3OQ%3D%3D%7Ce5fe39d8b45d7b4f5b0ef2a31ef33bfb&night=0&crt=1664369941&time_zone=Asia%2FShanghai&client=634510FA-B7A2-4295-BE84-14CA669C712F&bddid=HVKYUEZNE3XBOE7V4CKOBA2WAJJHZOW7CSIXERKY5N4OR5C6YXSA01
/// huputiyu://bbs/topicTag?tagId=34997&clt=d1fa2b2a-3fb6-0f01-0b1f-f1df0242f9f5&r=kqappshare_news
class _HupuHotState extends State<HupuHot> with AutomaticKeepAliveClientMixin {
  int activeIndex = 0;

  bool _loading = true;

  final int maxRows = 20;

  List<dynamic> rankHotList = [];

  List<List<PostResp>> allHotList = [];

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
    if (allHotList[index - 1].isNotEmpty) return;
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
                  pics: e['thread']['pics'] != null
                      ? e['thread']['pics'].map<Pics>((ele) {
                          return Pics(url: ele['url']);
                        }).toList()
                      : []),
            ),
          )
          .toList();
      setState(() {
        _loading = false;
        allHotList[index - 1] = [...list];
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
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _buildHotListItem(int i, int index) {
    print(i);
    return ShimmerLoading(
      key: Key('$index'),
      isLoading: _loading,
      child: PostHotListItem(
        loading: _loading,
        child: allHotList[i].isNotEmpty
            ? Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Color.fromRGBO(240, 241, 245, 1),
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            children: [
                              Text(
                                allHotList[i][index].thread.title,
                                style: const TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              allHotList[i][index].thread.topic_name,
                              style: const TextStyle(
                                color: Color.fromRGBO(133, 144, 166, 1),
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    buildPostImage(allHotList[i][index].thread),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  Widget buildPostImage(PostHeader data) {
    if (data.video != null) {
      return Image.network(
        data.video!.img,
        width: 56,
        height: 80,
      );
    }
    if (data.pics != null && data.pics!.isNotEmpty) {
      return Image.network(
        data.pics![0].url,
        width: 56,
        height: 80,
      );
    }
    return Container();
  }

  List<Widget> _buildList() {
    List<Widget> children = [
      Shimmer(
        // key: const Key('0'),
        child: ListView(
          physics: _loading ? const NeverScrollableScrollPhysics() : null,
          children:
              List.generate(maxRows, (index) => _buildRankListItem(index)),
        ),
      ),
    ];
    for (var i = 1; i < tagsList.length; i++) {
      children.add(
        Shimmer(
          key: Key('$i'),
          child: ListView(
            physics: _loading ? const NeverScrollableScrollPhysics() : null,
            children: List.generate(
                allHotList[i - 1].isEmpty ? maxRows : allHotList[i - 1].length,
                (index) => _buildHotListItem(i - i, index)),
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
            onTap: (int i) async {
              if (i > 0) {
                await initPostList(i);
                setState(() {});
              }
            },
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

class PostHotListItem extends StatelessWidget {
  const PostHotListItem({Key? key, required this.loading, required this.child})
      : super(key: key);

  final bool loading;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 250,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 72,
            height: 32,
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
    }
    return child;
  }
}

class RankHotListItem extends StatelessWidget {
  const RankHotListItem({Key? key, required this.loading, required this.child})
      : super(key: key);

  final bool loading;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 8,
          ),
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: 250,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      );
    }
    return child;
  }
}

class ClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var p = Path();
    p.moveTo(size.width * 0.2, 0);
    p.lineTo(size.width, 0);
    p.lineTo(size.width * 0.8, size.height);
    p.lineTo(0, size.height);
    p.lineTo(size.width * 0.2, 0);
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
