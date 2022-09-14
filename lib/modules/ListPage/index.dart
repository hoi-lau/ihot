import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'ListPage',
      style: TextStyle(color: Colors.white),
    );
  }
}
