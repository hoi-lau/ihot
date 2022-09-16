import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/AppTheme.dart';
import '../../utils/localNotify.dart';
import '../Home/BodyEditor.dart';
import '../Home/TitleEditor.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatefulWidgetState();
  }
}

class _StatefulWidgetState extends State<EditorPage> {
  String title = '';

  String content = '';

  void onSubmit() {}

  void updateTitle(String text) {
    title = text;
    print(title);
  }

  void updateContent(String text) {
    content = text;
    print(content);
  }

  void handleEnter() {
    bodyEditorKey.currentState?.setEditorFocus();
    var notify = LocalNotification();
    notify.send('title', 'body)');
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      print('object');
      titleEditorKey.currentState?.controller.text = 'title';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          CupertinoButton(
            onPressed: () {},
            child: const Text(
              "完成",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              TitleEditor(
                key: titleEditorKey,
                title: title,
                updateFn: updateTitle,
                handleEnter: handleEnter,
              ),
              Expanded(
                child: BodyEditor(
                  key: bodyEditorKey,
                  content: content,
                  updateFn: updateContent,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.label_important_outline_rounded,
                    color: appTheme.homeTheme.getFontColor().withOpacity(.7),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.alarm,
                    color: appTheme.homeTheme.getFontColor().withOpacity(.7),
                  ),
                  const SizedBox(width: 20),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
