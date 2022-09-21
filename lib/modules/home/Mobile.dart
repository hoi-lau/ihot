import 'dart:convert';

import 'package:app/components/dialog/IOSDialog.dart';
import 'package:app/components/search_input/index.dart';
import 'package:app/config/AppTheme.dart';
import 'package:app/constant/Constant.dart';
import 'package:app/data/api/Home.dart';
import 'package:app/data/model/Home.dart';
import 'package:app/modules/Home/TaskLabelList.dart';
import 'package:app/utils/EvenBus.dart';
import 'package:app/utils/SharedPrefs.dart';
import 'package:app/utils/index.dart';
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

  List<TaskLabelModel> labelList = [];

  bool offline = false;

  final TextEditingController controller = TextEditingController(text: '');

  final TextEditingController labelController = TextEditingController(text: '');

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
    initListener();
  }

  Future<void> initData() async {
    await sharedPrefsUtils.initSharedPref();
    initDataFromCache();
    // fetchListData();
  }

  void initDataFromCache() {
    var cachedLabelList = sharedPrefsUtils.getObjectList<TaskLabelModel>(
        'labelList', TaskLabelModel.fromJsonString);
    if (cachedLabelList != null) {
      setState(() {
        labelList = [...cachedLabelList];
      });
    }
  }

  Future<void> fetchListData() async {
    var data = await fetchLabelList();
    setState(() {
      labelList = [...data];
    });
    sharedPrefsUtils.setObjectList('labelList', data);
  }

  void initListener() {
    bus.on('network', (arg) {
      setState(() {
        offline = arg;
      });
    });
    bus.on('updateHome', (arg) {
      initData();
    });
  }

  Future<bool> handleLabelAdd(String text) async {
    if (text.isNotEmpty) {
      await addLabel(TaskLabelModel(title: text));
      await initData();
      return true;
    } else {
      return false;
    }
  }

  void handleSearchInputChange(e) {}

  void handleFolderTap(BuildContext context) {
    labelController.text = '';
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return IOSStyleDialog(
          context: context,
          title: '新建标签',
          confirmTxt: '确认',
          confirmColor: const Color.fromRGBO(0, 122, 255, 1),
          onTap: () async {
            bool closeDialog = await handleLabelAdd(labelController.text);
            return closeDialog;
          },
          cancelCallback: (context) {
            closeKeyboard(context);
          },
          body: Material(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 32,
              ),
              child: TextField(
                controller: labelController,
                cursorWidth: 1.5,
                autofocus: true,
                cursorColor: Colors.orange,
                onChanged: (e) {},
                decoration: InputDecoration(
                  hintText: '名称',
                  filled: true,
                  contentPadding: const EdgeInsets.only(left: 8, right: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: appTheme.homeTheme.getBgColor(),
          // centerTitle: true,
          toolbarHeight: 36,
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    '${Constant.ASSETS_IMG}favicon.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
          title: offline
              ? Text(
                  'offline',
                  style: TextStyle(color: appTheme.homeTheme.getFontColor()),
                )
              : null,
          // actions: <Widget>[
          //   CupertinoButton(
          //     onPressed: () {
          //       handleAction();
          //     },
          //     padding: const EdgeInsets.all(0.0),
          //     child: Text(
          //       appBarText,
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //           color: appTheme.homeTheme.getFontColor(), fontSize: 14),
          //     ),
          //   ),
          // ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: appTheme.homeTheme.getBgColor(),
          ),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              //   child: SearchInput(
              //     handleInputChange: handleSearchInputChange,
              //     enabled: appBarText == HomeAction.edit,
              //   ),
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TaskLabelList(
                    dataList: labelList,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        handleFolderTap(context);
                      },
                      child: Icon(
                        Icons.new_label_sharp,
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
        ),
      ),
    );
  }
}
