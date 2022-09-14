import 'package:flutter/material.dart';

///影片、电视详情页面
class DetailPage extends StatefulWidget {
  final subjectId;

  const DetailPage(this.subjectId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState(subjectId);
  }
}

class _DetailPageState extends State<DetailPage> {
  final subjectId;

  _DetailPageState(this.subjectId);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Text('text'),
        ));
  }
}
