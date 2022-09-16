import 'package:app/modules/app_container/index.dart';
import 'package:flutter/material.dart';

// import '../modules/Detail/index.dart';

class MyRouter {
  static const homePage = 'app://';
  static const detailPage = 'app://DetailPage';

  Widget _getPage(String url, dynamic params) {
    // if (url.startsWith('https://') || url.startsWith('http://')) {
    //   return WebViewPage(url, params: params);
    // } else {
    switch (url) {
      // case detailPage:
      //   return DetailPage(params);
      case homePage:
        return const AppContainer();
      default:
        return const AppContainer();
    }
    // }
    // return null;
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
}
