import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/constant/Constant.dart';
import 'package:app/modules/hot_home/hot_home.dart';
import 'package:app/routes/index.dart';
import 'package:app/utils/index.dart';

class ZhihuHot extends StatefulWidget {
  const ZhihuHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ZhihuHotState();
  }
}

class _ZhihuHotState extends State<ZhihuHot>
    with AutomaticKeepAliveClientMixin {
  bool _loading = true;

  List<ZhihuItem> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchListData();
  }

  Future<void> fetchListData() async {
    setState(() {
      _loading = true;
    });
    var url =
        'https://api.zhihu.com/topstory/hot-list?limit=20&reverse_order=0&upnews_exp=3';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      List<ZhihuItem> list = data['data']
          .map<ZhihuItem>((e) => ZhihuItem(
                title: e['target']['title'],
                detail: e['detail_text'],
                url: e['target']['url'],
                thumbnail: e['children'][0]['thumbnail'],
                excerpt: e['target']['excerpt'],
              ))
          .toList();
      setState(() {
        dataList = [...list];
        _loading = false;
      });
    }
  }

  Widget _buildZhihuItem(int index) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: _loading,
        child: ZhihuLoading(
          loading: _loading,
          data: dataList.isNotEmpty ? dataList[index] : null,
          index: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await fetchListData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Success!'),
            duration: const Duration(milliseconds: 1500),
            width: 100.0,
            // backgroundColor: const Color.fromRGBO(0, 0, 0, 0.1),
            backgroundColor: Colors.blueAccent,
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
        children: List.generate(dataList.isEmpty ? 20 : dataList.length,
            (index) => _buildZhihuItem(index)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ZhihuItem {
  ZhihuItem({
    required this.title,
    required this.url,
    required this.detail,
    required this.thumbnail,
    required this.excerpt,
  });

  final String title;
  final String url;
  final String detail;
  final String thumbnail;
  final String excerpt;
}

class ZhihuLoading extends StatelessWidget {
  const ZhihuLoading({
    Key? key,
    required this.loading,
    required this.index,
    this.data,
  }) : super(key: key);

  final bool loading;

  final ZhihuItem? data;

  final int index;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48,
                    margin: const EdgeInsets.only(top: 2, bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 68,
              height: 68,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
      );
    }
    if (data == null) return Container();
    ZhihuItem model = data!;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(229, 231, 235, 1)),
        ),
      ),
      padding: const EdgeInsets.only(top: 12, right: 8, bottom: 12, left: 8),
      child: GestureDetector(
        onTap: () {
          String url =
              model.url.replaceFirst(RegExp(r'api.zhihu.com/questions'), 'zhihu.com/question');
          MyRouter.goWebView(context, url);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 2, right: 8),
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Color.fromRGBO(255, 150, 7, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: Colors.redAccent,
                          size: 16,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          child: Text(
                            model.detail,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(153, 153, 153, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Image.network(
                  model.thumbnail,
                  width: 68,
                  height: 68,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
