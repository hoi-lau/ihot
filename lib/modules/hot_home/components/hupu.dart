import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/modules/hot_home/hot_home.dart';
import 'package:flutter/material.dart';

class HupuHot extends StatefulWidget {
  const HupuHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HupuHotState();
  }
}

/// https://bbs.mobileapi.hupu.com/3/7.5.56/bbsallapi/tag/v1/heatTag
/// https://games.mobileapi.hupu.com/3/7.5.56/hotRank/?sign=571179e0844a9606eec015c6a0e8482c&category=70003&clientId=102750844&deviceId=BtCkC6CGNpJxt2S1GVXjY7S6GRVtxgQpL%2BIeC8RNz16fNWfJaL0iF7zo4iJrVkJctPhAnY3FKiNQ9e%2BRif4%2B05g%3D%3D&cid=102750844&puid=96756348&token=NDYxNzY2MTg%3D%7CMTY1MzI5OTU3OQ%3D%3D%7Ce5fe39d8b45d7b4f5b0ef2a31ef33bfb&night=0&crt=1664369941&time_zone=Asia%2FShanghai&client=634510FA-B7A2-4295-BE84-14CA669C712F&bddid=HVKYUEZNE3XBOE7V4CKOBA2WAJJHZOW7CSIXERKY5N4OR5C6YXSA01
/// 80000
class _HupuHotState extends State<HupuHot> {
  int activeIndex = 0;

  bool _loading = true;

  final int maxRows = 20;

  List<dynamic> hotList = [];

  @override
  void initState() {
    super.initState();
    initList();
  }

  Future<void> initList() async {
    _loading = true;
    var request = await httpClient.getUrl(Uri.parse(
        'https://bbs.mobileapi.hupu.com/3/7.5.56/bbsallapi/tag/v1/heatTag'));
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data['data']['content']);
      hotList = [...data['data']['content']];
      _loading = false;
      setState(() {});
    } else {
      // error deal
    }
  }

  Widget _buildListItem(int index) {
    return ShimmerLoading(
      key: Key('$index'),
      isLoading: _loading,
      child: HotListItem(
        loading: _loading,
        child: hotList.isNotEmpty
            ? Container(
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
                child: Text(hotList[index]['description']),
              )
            : Container(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListView(
          physics: _loading ? const NeverScrollableScrollPhysics() : null,
          children: List.generate(maxRows, (index) => _buildListItem(index))),
    );
  }
}

class HotListItem extends StatelessWidget {
  HotListItem({Key? key, required this.loading, required this.child})
      : super(key: key);

  final bool loading;

  Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
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
      );
    }
    return child;
  }
}
