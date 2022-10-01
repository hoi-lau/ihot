import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class GithubHot extends StatefulWidget {
  const GithubHot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GithubHotState();
  }
}

var httpClient = HttpClient();

enum DateRange { daily, weekly, monthly }

class _GithubHotState extends State<GithubHot> {
  int activeIndex = 0;

  static List<String> langList = [
    'JavaScript',
    'TypeScript',
    'CSS',
    'Vue',
    'Shell',
    'Java',
    'C++',
    'Dart'
  ];

  @override
  void initState() {
    super.initState();
    initAllResp();
  }

  Future<void> initAllResp() async {
    var request = await httpClient.getUrl(Uri.parse(
        'https://github-trending.p.rapidapi.com/repositories?language=JavaScript&since=monthly'));
    request.headers.add('X-Rapidapi-Host', 'github-trending.p.rapidapi.com');
    request.headers.add(
        'X-Rapidapi-Key', '31c5a0f5a4msh58e2775878e23e4p1694a9jsnc670d4641f42');
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      print(data);
      // _loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text('_GithubHotState');
  }
}
