import 'package:app/config/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MobileHomeState();
  }
}

class HomeAction {
  static const String edit = '编辑';

  static const String complete = '完成';
}

class _MobileHomeState extends State<MobileHome> {
  String appBarText = HomeAction.edit;

  void handleAction() {
    setState(() {
      switch (appBarText) {
        case HomeAction.edit:
          appBarText = HomeAction.complete;
          break;
        case HomeAction.complete:
          appBarText = HomeAction.edit;
          break;
      }
      // appBarText = (appBarText == HomeAction.edit ? HomeAction.complete : HomeAction.edit);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            backgroundColor: appTheme.homeTheme.getBgColor(),
            centerTitle: true,
            actions: <Widget>[
              CupertinoButton(
                onPressed: () {
                  handleAction();
                },
                child: Text(
                  appBarText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.orange, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
