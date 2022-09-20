import 'package:app/components/dialog/IOSDialog.dart';
import 'package:app/components/search_input/index.dart';
import 'package:app/config/AppTheme.dart';
import 'package:app/data/api/Home.dart';
import 'package:app/data/model/Home.dart';
import 'package:app/modules/Home/TaskLabelList.dart';
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

  final TextEditingController controller = TextEditingController(text: '');

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
  }

  void initData() async {
    var data = await fetchLabelList();
    setState(() {
      labelList = [...data];
    });
  }

  void handleSearchInputChange(e) {}

  void handleFolderTap(BuildContext context) {
    controller.text = '';
    showIOSStyleDialog(
      context: context,
      title: '新建标签',
      confirmTxt: '确认',
      confirmColor: Colors.blue,
      onTap: () {
        print(controller.text);
        // updateLabel();
      },
      body: Material(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 32,
          ),
          child: TextField(
            controller: controller,
            cursorWidth: 1.5,
            decoration: InputDecoration(
              hintText: '名称',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: appTheme.homeTheme.getBgColor()),
              ),
            ),
          ),
        ),
      ),
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
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                child: SearchInput(
                  handleInputChange: handleSearchInputChange,
                  enabled: appBarText == HomeAction.edit,
                ),
              ),
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
