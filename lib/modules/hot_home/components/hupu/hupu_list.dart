import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/modules/hot_home/components/hupu/model.dart';
import 'package:app/modules/hot_home/hot_home.dart';
import 'package:app/routes/index.dart';
import 'package:flutter/material.dart';

class PostHotList extends StatefulWidget {
  const PostHotList({Key? key, required this.tagId, this.maxRows = 20})
      : super(key: key);

  final int tagId;

  final int maxRows;

  @override
  State<StatefulWidget> createState() {
    return _PostHotListState();
  }
}

class _PostHotListState extends State<PostHotList>
    with AutomaticKeepAliveClientMixin {
  List<PostResp> listData = [];
  int i = 0;

  bool _loading = true;

  @override
  void initState() {
    print(widget.tagId);
    super.initState();
    fetchListData();
  }

  Future<void> fetchListData() async {
    var timestamp = '${DateTime.now().millisecondsSinceEpoch}';
    var url =
        'https://games.mobileapi.hupu.com/3/7.5.56/hotRank/?category=${widget.tagId}&cid=102750844&crt=${timestamp.substring(0, 10)}';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
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
        listData = [...list];
        _loading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // action: SnackBarAction(
          //   label: 'Action',
          //   onPressed: () {
          //     // Code to execute.
          //   },
          // ),
          content: const Text('Http error!'),
          duration: const Duration(milliseconds: 1500),
          width: 100.0,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
          // Width of the SnackBar.
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  Widget _buildHotListItem(int index) {
    return ShimmerLoading(
      key: Key('$index'),
      isLoading: _loading,
      child: PostHotListItem(
        loading: _loading,
        child: listData.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  String shareUrl = listData[index].thread.share.url;
                  MyRouter.goWebView(context, shareUrl);
                },
                child: Container(
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
                                  listData[index].thread.title,
                                  style: const TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Text(
                                listData[index].thread.topic_name,
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
                      buildPostImage(listData[index].thread),
                    ],
                  ),
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        await fetchListData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // action: SnackBarAction(
            //   label: 'Action',
            //   onPressed: () {
            //     // Code to execute.
            //   },
            // ),
            content: const Text('Success!'),
            duration: const Duration(milliseconds: 1500),
            width: 100.0,
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
            // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8.0,
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      },
      child: ListView(
        physics: _loading ? const NeverScrollableScrollPhysics() : null,
        children: List.generate(
            listData.isEmpty ? widget.maxRows : listData.length,
            (index) => _buildHotListItem(index)),
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
