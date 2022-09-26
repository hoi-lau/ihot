import 'package:app/components/dialog/IOSDialog.dart';
import 'package:app/config/AppTheme.dart';
import 'package:app/constant/Constant.dart';
import 'package:app/data/database/api/home.dart';
import 'package:app/data/model/Home.dart';
import 'package:app/modules/Home/TaskLabelList.dart';
import 'package:app/modules/app_container/app_bar.dart';
import 'package:app/routes/index.dart';
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

  int activeIndex = 0;

  final TextEditingController controller = TextEditingController(text: '');

  final TextEditingController labelController = TextEditingController(text: '');

  void handleAction() {
    // setState(() {
    //   switch (appBarText) {
    //     case HomeAction.edit:
    //       appBarText = HomeAction.complete;
    //       break;
    //     case HomeAction.complete:
    //       appBarText = HomeAction.edit;
    //       break;
    //   }
    // });
    MyRouter.push(context, MyRouter.searchPage, "id=hahaha");
  }

  @override
  void initState() {
    super.initState();
    initData();
    initListener();
  }

  Future<void> initData() async {
    fetchListData();
  }

  Future<void> fetchListData() async {
    var data = await queryLabelList();
    setState(() {
      labelList = [...data];
    });
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
      var label = TaskLabelModel(title: text, id: getUid());
      labelList.insert(labelList.length - 1, label);
      setState(() {});
      await addTaskLabel(label);
      await fetchListData();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> handleLabelUpdate(String text) async {
    if (text == labelList[activeIndex].title) {
      return true;
    } else if (text.isNotEmpty) {
      labelList[activeIndex].title = text;
      setState(() {});
      await updateTaskLabel(
          TaskLabelModel(title: text, id: labelList[activeIndex].id));
      fetchListData();
      return true;
    }
    return false;
  }

  void handleLabelDel(int index) {
    if (labelList[index].id! > 0) {
      delTaskLabel(TaskLabelModel(
          id: labelList[index].id, title: labelList[index].title));
      fetchListData();
    }
    labelList.removeAt(index);
    setState(() {});
  }

  void handleLabelEdit(int index) {
    activeIndex = index;
    labelController.text = labelList[index].title;
    handleFolderTap(context);
  }

  void handleSearchInputChange(e) {}

  void handleFolderTap(BuildContext context) {
    // labelController.text = '';
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return IOSStyleDialog(
          context: context,
          title: '新建标签',
          confirmTxt: '确认',
          confirmColor: appTheme.appleBlue,
          onTap: () async {
            if (activeIndex < 0) {
              handleLabelAdd(labelController.text);
            } else {
              handleLabelUpdate(labelController.text);
            }
            return true;
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
        appBar: faireAppBar(
          actions: <Widget>[
            CupertinoButton(
              onPressed: () {
                handleAction();
              },
              padding: const EdgeInsets.all(0.0),
              child: Icon(
                Icons.search_outlined,
                color: appTheme.appleBlue,
              ),
            ),
          ],
        ),
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: appTheme.homeTheme.getBgColor(),
        //   // centerTitle: true,
        //   toolbarHeight: 36,
        //   leading: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Flexible(
        //         child: GestureDetector(
        //           child: ClipRRect(
        //             borderRadius: const BorderRadius.all(Radius.circular(12)),
        //             child: Image.asset(
        //               '${Constant.ASSETS_IMG}favicon.png',
        //               width: 24,
        //               height: 24,
        //             ),
        //           ),
        //           onTap: () {
        //             // MyRouter.push(context, MyRouter.appOverviewPage, '');
        //             bus.emit('page-change', 0);
        //           },
        //         ),
        //       ),
        //     ],
        //   ),
        //   title: offline
        //       ? Text(
        //           'offline',
        //           style: TextStyle(color: appTheme.homeTheme.getFontColor()),
        //         )
        //       : null,
        //   actions: <Widget>[
        //     CupertinoButton(
        //       onPressed: () {
        //         handleAction();
        //       },
        //       padding: const EdgeInsets.all(0.0),
        //       child: Icon(
        //         Icons.search_outlined,
        //         color: appTheme.appleBlue,
        //       ),
        //     ),
        //   ],
        // ),
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
                    handleLabelEdit: handleLabelEdit,
                    handleLabelDel: handleLabelDel,
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
                        labelController.text = '';
                        activeIndex = getUid();
                        handleFolderTap(context);
                      },
                      child: Icon(
                        Icons.new_label_sharp,
                        color: appTheme.homeTheme.getFontColor(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        MyRouter.push(context, MyRouter.editorPage, "params");
                      },
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
