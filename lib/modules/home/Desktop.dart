import 'package:flutter/material.dart';

import 'BodyEditor.dart';
import 'TitleEditor.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DesktopHomeState();
  }
}

class _DesktopHomeState extends State<DesktopHome> {
  String title = '';

  String content = '';

  void onSubmit() {}

  void updateTitle(String text) {
    title = text;
  }

  void updateContent(String text) {
    content = text;
  }

  void handleEnter() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, .1),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TitleEditor(
                title: title,
                updateFn: updateTitle,
                handleEnter: handleEnter,
              ),
              BodyEditor(
                content: content,
                updateFn: updateContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
