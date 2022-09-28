import 'package:app/config/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar faireAppBar(
    {required BuildContext context, Widget? title, List<Widget>? actions}) {
  return AppBar(
    elevation: 0,
    backgroundColor: appTheme.homeTheme.getBgColor(),
    toolbarHeight: 42,
    leading: CupertinoButton(
      onPressed: () {
        // MyRouter.push(context, MyRouter.appOverviewPage, '');
      },
      padding: const EdgeInsets.all(0.0),
      // child: Hero(
      //   tag: 'home-page',
      //   child: Image.asset(
      //     '${Constant.ASSETS_IMG}favicon.png',
      //     width: 20,
      //     height: 20,
      //   ),
      // ),
      child: Icon(
        Icons.list,
        color: appTheme.gray,
      ),
    ),
    title: title,
    actions: actions,
  );
}
