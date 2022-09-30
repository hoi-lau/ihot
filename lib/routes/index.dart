import 'package:app/components/WebViewPage.dart';
import 'package:app/modules/app_container/data.dart';
import 'package:app/modules/editor_page/index.dart';
import 'package:app/modules/search_page/index.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static const homePage = 'app://';
  static const appOverviewPage = 'app://OverviewPage';
  static const searchPage = 'app://SearchPage';
  static const editorPage = 'app://EditorPage';
  static const detailPage = 'app://DetailPage';

  Widget _getPage(String url, dynamic params) {
    // if (url.startsWith('https://') || url.startsWith('http://')) {
    //   return WebViewPage(
    //     url: url,
    //   );
    // }
    Widget res;
    switch (url) {
      case homePage:
        res = outsidePages[1];
        break;
      case searchPage:
        res = const SearchPage();
        break;
      case appOverviewPage:
        res = outsidePages[0];
        break;
      case editorPage:
        res = EditorPage(projectId: params);
        break;
      default:
        res = outsidePages[1];
        break;
    }
    return res;
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

  MyRouter.goWebView(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WebViewPage(
        url: url,
      );
    }));
  }

  MyRouter.pop(BuildContext context) {
    Navigator.pop(context);
  }
}
