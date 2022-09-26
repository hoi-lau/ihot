import 'package:app/modules/app_container/index.dart';
import 'package:app/modules/app_overview/index.dart';
import 'package:app/modules/editor_page/index.dart';
import 'package:app/modules/home/index.dart';
import 'package:app/modules/search_page/index.dart';
import 'package:flutter/material.dart';

const List<Widget> pages = [Home(), SearchPage(), AppOverview()];

Widget appOverviewHeroWrap = Container();

class MyRouter {
  static const homePage = 'app://';
  static const appOverviewPage = 'app://OverviewPage';
  static const searchPage = 'app://SearchPage';
  static const editorPage = 'app://EditorPage';
  static const detailPage = 'app://DetailPage';

  Widget _getPage(String url, dynamic params) {
    // if (url.startsWith('https://') || url.startsWith('http://')) {
    //   return WebViewPage(url, params: params);
    // } else {
    Widget res;
    switch (url) {
      case homePage:
        res = pages[0];
        break;
      case searchPage:
        res = pages[1];
        break;
      case appOverviewPage:
        res = pages[2];
        break;
      case editorPage:
        res = EditorPage(projectId: params);
        break;
      default:
        res = pages[0];
        break;
    }
    return AppContainer(
      child: res,
    );
  }

  MyRouter.pushNoParams(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, null);
    }));
  }

  MyRouter.push(BuildContext context, String url, dynamic params) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return _getPage(url, params);
    }));
  }

  MyRouter.pop(BuildContext context) {
    Navigator.pop(context);
  }
}
