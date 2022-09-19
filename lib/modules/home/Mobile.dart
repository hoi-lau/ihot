import 'package:app/components/search_input/index.dart';
import 'package:app/config/AppTheme.dart';
import 'package:app/fetch/HttpUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TaskLabelList.dart';

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
    initData();
    // Http http = Http();
    // http
    //     .get('http://localhost:6789/v1/sys/menu/tree')
    //     .then((value) => {print(value)});
  }

  void initData() {

  }

  void handleSearchInputChange(e) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appTheme.homeTheme.getBgColor(),
            // centerTitle: true,
            toolbarHeight: 30,
            actions: <Widget>[
              CupertinoButton(
                onPressed: () {
                  handleAction();
                },
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  appBarText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: appTheme.homeTheme.getFontColor(), fontSize: 14),
                ),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              color: appTheme.homeTheme.getBgColor(),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: SearchInput(
                    handleInputChange: handleSearchInputChange,
                    enabled: appBarText == HomeAction.edit,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: TaskLabelList(
                      dataList: [],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.create_new_folder_rounded,
                          color: appTheme.homeTheme.getFontColor(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.edit_note,
                          color: appTheme.homeTheme.getFontColor(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
