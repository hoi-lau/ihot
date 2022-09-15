import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BodyEditor.dart';
import 'TitleEditor.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MobileHomeState();
  }
}

class _MobileHomeState extends State<MobileHome> {
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
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleEditor(
                title: title,
                updateFn: updateTitle,
              ),
              BodyEditor(
                content: content,
                updateFn: updateContent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
