import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/constant/Constant.dart';
import 'package:app/modules/hot_home/hot_home.dart';
import 'package:app/routes/index.dart';
import 'package:flutter/material.dart';

class WeiboHot extends StatefulWidget {
  const WeiboHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WeiboHotState();
  }
}

class _WeiboHotState extends State<WeiboHot>
    with AutomaticKeepAliveClientMixin {
  bool _loading = true;

  List<WeiboItem> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchListData();
  }

  Future<void> fetchListData() async {
    setState(() {
      _loading = true;
    });
    var url = 'https://weibo.com/ajax/side/hotSearch';
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      List<WeiboItem> list = data['data']['realtime']
          .where((e) => e['word_scheme'] != null)
          .map<WeiboItem>((e) => WeiboItem(
              isNew: e['is_new'] ?? 0,
              note: e['note'],
              num: e['num'],
              wordScheme: e['word_scheme']))
          .toList();
      setState(() {
        dataList = [...list];
        _loading = false;
      });
    }
  }

  Widget _buildWeiboItem(int index) {
    return Shimmer(
      child: ShimmerLoading(
        isLoading: _loading,
        child: WeiboLoading(
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
            (index) => _buildWeiboItem(index)),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class WeiboItem {
  WeiboItem(
      {required this.note,
      required this.isNew,
      required this.num,
      required this.wordScheme});

  final String note;
  final String wordScheme;
  final int isNew;
  final int num;
}

class WeiboLoading extends StatelessWidget {
  const WeiboLoading({
    Key? key,
    required this.loading,
    required this.index,
    this.data,
  }) : super(key: key);

  final bool loading;

  final WeiboItem? data;

  final int index;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        margin: const EdgeInsets.only(top: 8, bottom: 4),
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Container(
          height: 32,
          margin: const EdgeInsets.only(top: 4, bottom: 2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
    }
    if (data == null) return Container();
    WeiboItem model = data!;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(229, 231, 235, 1)),
        ),
      ),
      padding: const EdgeInsets.only(top: 12, right: 8, bottom: 12, left: 8),
      child: GestureDetector(
        onTap: () {
          String url = 'https://s.weibo.com/weibo?q=${model.wordScheme}';
          MyRouter.goWebView(context, url);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 2, right: 8),
                  width: index < 3 ? 45 : 32,
                  height: index < 3 ? 22 : 18,
                  padding: EdgeInsets.only(left: index < 3 ? 8 : 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage(
                            '${Constant.ASSETS_IMG}wb_hot_rank${index < 3 ? index + 1 : '_default'}.png')),
                  ),
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      height: index < 3 ? 1.9 : 1.4,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                '热度值: ${model.num}',
                style: const TextStyle(
                    fontSize: 12, color: Color.fromRGBO(153, 153, 153, 1)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
