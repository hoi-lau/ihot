import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/constant/Constant.dart';
import 'package:app/modules/hot_home/components/bilibili/model.dart';
import 'package:app/modules/hot_home/hot_home.dart';
import 'package:app/routes/index.dart';
import 'package:app/utils/index.dart';
import 'package:flutter/material.dart';

import 'bilibili.dart';

class BilibiliHotView extends StatefulWidget {
  const BilibiliHotView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BilibiliHotViewState();
  }
}

class _BilibiliHotViewState extends State<BilibiliHotView>
    with AutomaticKeepAliveClientMixin {
  List<BiliHotItem> dataList = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchListData();
  }

  Future<void> fetchListData() async {
    setState(() {
      _loading = true;
    });
    var url = 'https://api.bilibili.com/x/web-interface/popular?ps=20&pn=1';
    var request = await httpClient.getUrl(Uri.parse(url));
    request.headers.set('cookie',
        'innersign=0; buvid3=660A255F-3F66-78A7-87DF-DA3EDA7FCC7C05404infoc; b_nut=1665279705; i-wanna-go-back=-1; b_ut=7; b_lsid=178F10EBD_183BA67C1E7; _uuid=CBF109DD2-181B-2FC5-76E7-A3F5C3A5731905593infoc; buvid_fp=d801421afc3ae5b07bac6c8f23004d11; buvid4=96615CC0-906E-3E6E-78C6-AEA8BC00912D09576-022100909-sZiQyrxq7Q7L7D8CzHRFCg%3D%3D; PVID=1');
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      List<BiliHotItem> list = data['data']['list']
          .map<BiliHotItem>(
            (e) => BiliHotItem(
                title: e['title'],
                ownerName: e['owner']['name'],
                rcmdReasonContent: e['rcmd_reason']['content'],
                rcmdReasonCornerMark: e['rcmd_reason']['corner_mark'],
                view: e['stat']['view'],
                pic: e['pic'],
                shortLinkV2: e['short_link_v2'],
                danmaku: e['stat']['danmaku']),
          )
          .toList();
      setState(() {
        dataList = [...list];
        _loading = false;
      });
    }
  }

  Widget _buildBiliHotItem(int index) {
    return ShimmerLoading(
      key: Key('$index'),
      isLoading: _loading,
      child: dataList.isNotEmpty
          ? BiliLoading(
              loading: _loading,
              child: GestureDetector(
                onTap: () {
                  MyRouter.goWebView(context, dataList[index].shortLinkV2);
                },
                child: Container(
                  height: 108,
                  margin: const EdgeInsets.only(bottom: 12, top: 12),
                  padding: const EdgeInsets.only(right: 4),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 8, right: 8),
                        child: Image.network(
                          dataList[index].pic,
                          width: 176,
                          height: 108,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(
                              child: Text('404'),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                dataList[index].title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                            dataList[index].rcmdReasonContent.isNotEmpty
                                ? Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromRGBO(255, 241, 237, 1),
                                      border: Border.fromBorderSide(
                                        BorderSide(
                                            color: Color.fromRGBO(
                                                255, 102, 51, 1)),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 2, right: 2),
                                    margin: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      dataList[index].rcmdReasonContent,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(255, 102, 51, 1),
                                      ),
                                    ),
                                  )
                                : Container(),
                            Row(
                              children: [
                                Image.asset(
                                  '${Constant.ASSETS_IMG}icon_up.png',
                                  width: 16,
                                  height: 16,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 2),
                                  child: Text(
                                    dataList[index].ownerName,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  '${Constant.ASSETS_IMG}video_play.png',
                                  width: 16,
                                  height: 16,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 4, right: 16),
                                  child: Text(
                                    number2W(dataList[index].view),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                ),
                                Image.asset(
                                  '${Constant.ASSETS_IMG}video_danmaku.png',
                                  width: 16,
                                  height: 16,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 2, right: 4),
                                  child: Text(
                                    number2W(dataList[index].danmaku),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(153, 153, 153, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // super.build(context);
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
            (index) => _buildBiliHotItem(index)),
      ),
    );
  }
}

class BiliHotItem extends BiliItem {
  BiliHotItem({
    required super.pic,
    required super.title,
    required super.ownerName,
    required super.view,
    required super.danmaku,
    required super.shortLinkV2,
    required this.rcmdReasonContent,
    required this.rcmdReasonCornerMark,
  });

  final int rcmdReasonCornerMark;
  final String rcmdReasonContent;
}
