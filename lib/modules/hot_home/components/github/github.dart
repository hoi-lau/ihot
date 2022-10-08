import 'dart:convert';
import 'dart:io';

import 'package:app/components/shimmer/shimmer.dart';
import 'package:app/constant/Constant.dart';
import 'package:app/routes/index.dart';
import 'package:app/utils/color_util.dart';
import 'package:app/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  int _selectedLang = 0;

  int _activeLang = 0;

  bool _loading = true;

  DateRange _activeDateRange = DateRange.weekly;

  final int maxRows = 20;

  final List<String> langList = [
    '全部',
    'JavaScript',
    'TypeScript',
    'CSS',
    'Shell',
    'Java',
    'C++',
    'Dart'
  ];

  List<TrendingItemModel> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataList();
  }

  Future<void> fetchDataList() async {
    String dateRange = '';
    String lang = _selectedLang == 0 ? '' : langList[_selectedLang];
    switch (_activeDateRange) {
      case DateRange.daily:
        dateRange = 'daily';
        break;
      case DateRange.weekly:
        dateRange = 'weekly';
        break;
      case DateRange.monthly:
        dateRange = 'monthly';
        break;
      default:
        dateRange = '';
        break;
    }
    setState(() {
      _loading = true;
    });
    var request = await httpClient.getUrl(Uri.parse(
        'https://github-trending.p.rapidapi.com/repositories?language=${lang}&since=${dateRange}'));
    request.headers.add('X-Rapidapi-Host', 'github-trending.p.rapidapi.com');
    request.headers.add(
        'X-Rapidapi-Key', '31c5a0f5a4msh58e2775878e23e4p1694a9jsnc670d4641f42');
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      var json = await response.transform(utf8.decoder).join();
      var data = jsonDecode(json);
      List<TrendingItemModel> list = data
          .map<TrendingItemModel>(
            (e) => TrendingItemModel(
                forks: e['forks'],
                currentPeriodStars: e['currentPeriodStars'],
                name: e['name'],
                description: e['description'] ?? '',
                avatar: e['avatar'] ?? '',
                author: e['author'] ?? '',
                language: e['language'] ?? '',
                url: e['url'],
                languageColor: e['languageColor'] ?? '',
                stars: e['stars']),
          )
          .toList();
      setState(() {
        _loading = false;
        dataList = [...list];
      });
    }
  }

  Widget _buildRankListItem(int index) {
    return ShimmerLoading(
      key: Key('$index'),
      isLoading: _loading,
      child: GithubTrendingItem(
        loading: _loading,
        data: dataList.isNotEmpty ? dataList[index] : null,
        currentDateRange: _activeDateRange,
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  Widget _buildToolBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color.fromRGBO(229, 231, 235, 1)),
          bottom: BorderSide(color: Color.fromRGBO(229, 231, 235, 1)),
        ),
      ),
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          const Text(
            'lang: ',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              _showDialog(
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xff999999),
                            width: 0.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CupertinoButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 5.0,
                            ),
                            child: const Text(
                              '取消',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          CupertinoButton(
                            onPressed: () {
                              setState(() {
                                _selectedLang = _activeLang;
                              });
                              fetchDataList();
                              Navigator.of(context).pop();
                            },
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 5.0,
                            ),
                            child: const Text('确认'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                              initialItem: _selectedLang),
                          onSelectedItemChanged: (int value) {
                            setState(() {
                              _activeLang = value;
                            });
                          },
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 32,
                          children: List.generate(
                            langList.length,
                            (index) => Center(
                              child: Text(
                                langList[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            child: Text(langList[_selectedLang],
                style: const TextStyle(
                    color: Color.fromRGBO(60, 126, 255, 1), fontSize: 14.0)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Radio<DateRange>(
                      activeColor: const Color.fromRGBO(60, 126, 255, 1),
                      value: DateRange.daily,
                      groupValue: _activeDateRange,
                      onChanged: (DateRange? value) {
                        setState(() {
                          _activeDateRange = value!;
                        });
                        fetchDataList();
                      },
                    ),
                    const Text('今天'),
                  ],
                ),
                Row(
                  children: [
                    Radio<DateRange>(
                      activeColor: const Color.fromRGBO(60, 126, 255, 1),
                      value: DateRange.weekly,
                      groupValue: _activeDateRange,
                      onChanged: (DateRange? value) {
                        setState(() {
                          _activeDateRange = value!;
                        });
                        fetchDataList();
                      },
                    ),
                    const Text('本周'),
                  ],
                ),
                Row(
                  children: [
                    Radio<DateRange>(
                      activeColor: const Color.fromRGBO(60, 126, 255, 1),
                      value: DateRange.monthly,
                      groupValue: _activeDateRange,
                      onChanged: (DateRange? value) {
                        setState(() {
                          _activeDateRange = value!;
                        });
                        fetchDataList();
                      },
                    ),
                    const Text('本月'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGithubTrendingItem() {
    return Shimmer(
      child: ListView(
        physics: _loading ? const NeverScrollableScrollPhysics() : null,
        children: List.generate(maxRows, (index) => _buildRankListItem(index)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 12,
          color: const Color.fromRGBO(246, 246, 246, 1),
        ),
        _buildToolBar(),
        Expanded(child: _buildGithubTrendingItem()),
      ],
    );
  }
}

class GithubTrendingItem extends StatelessWidget {
  const GithubTrendingItem(
      {Key? key,
      required this.loading,
      this.data,
      required this.currentDateRange})
      : super(key: key);

  final bool loading;

  final TrendingItemModel? data;

  final DateRange currentDateRange;

  String getDateRangeLabel(DateRange dr) {
    String res = '';
    switch (dr) {
      case DateRange.daily:
        res = 'today';
        break;
      case DateRange.weekly:
        res = 'this week';
        break;
      case DateRange.monthly:
        res = 'this month';
        break;
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Container(
                  width: 250,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  width: double.infinity,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
            height: 20,
          ),
        ],
      );
    }
    if (data == null) return Container();
    TrendingItemModel model = data!;
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(229, 231, 235, 1)),
        ),
      ),
      padding: const EdgeInsets.only(top: 12, right: 8, bottom: 12, left: 8),
      child: GestureDetector(
        onTap: () {
          String url = model.url;
          MyRouter.goWebView(context, url);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Image.asset(
                  '${Constant.ASSETS_IMG}repository.png',
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  width: 8,
                  height: 12,
                ),
                Text(
                  '${model.author} / ',
                  style: const TextStyle(
                    color: Color.fromRGBO(9, 105, 218, 1),
                    fontSize: 16,
                  ),
                ),
                Text(
                  model.name,
                  style: const TextStyle(
                      color: Color.fromRGBO(9, 105, 218, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              children: [
                Text(
                  model.description,
                  strutStyle: const StrutStyle(
                      forceStrutHeight: true, height: 0.2, leading: 1),
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      model.languageColor.isNotEmpty
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                width: 10,
                                height: 10,
                                color: HexColor.fromHex(model.languageColor),
                              ),
                            )
                          : Container(),
                      model.language.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.only(left: 4, right: 12),
                              child: Text(
                                model.language,
                                style: const TextStyle(fontSize: 14),
                              ),
                            )
                          : Container(),
                      Image.asset(
                        '${Constant.ASSETS_IMG}star.png',
                        width: 12,
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 2, right: 12),
                        child: Text(
                          thousandSeparate(model.stars),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Image.asset(
                        '${Constant.ASSETS_IMG}git-tree.png',
                        width: 12,
                        height: 12,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 2),
                        child: Text(
                          thousandSeparate(model.forks),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Row(
                  // alignment: WrapAlignment.end,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset(
                      '${Constant.ASSETS_IMG}star.png',
                      width: 12,
                      height: 12,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      child: Text(
                        thousandSeparate(model.currentPeriodStars),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Text(
                      'stars ${getDateRangeLabel(currentDateRange)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 12),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TrendingItemModel {
  TrendingItemModel({
    required this.author,
    required this.name,
    required this.avatar,
    required this.description,
    required this.url,
    required this.language,
    required this.languageColor,
    required this.stars,
    required this.forks,
    required this.currentPeriodStars,
  });

  final String author;

  final String name;

  final String avatar;

  final String description;

  final String url;

  final String language;

  final String languageColor;

  final int stars;

  final int forks;

  final int currentPeriodStars;
}
