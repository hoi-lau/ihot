import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/index.dart';

class TitleEditor extends StatefulWidget {
  const TitleEditor({Key? key, required this.title, required this.updateFn, required this.handleEnter}) : super(key: key);

  final String title;

  final Function updateFn;

  final Function handleEnter;

  @override
  State<StatefulWidget> createState() {
    return TitleEditorState();
  }
}

GlobalKey<TitleEditorState> titleEditorKey = GlobalKey();

class TitleEditorState extends State<TitleEditor> {
  @override
  void initState() {
    super.initState();
    controller.addListener(() {});
  }

  final TextEditingController controller = TextEditingController(text: '');

  void setTextFieldValue(String content) {
    controller.text = content;
    controller.selection = TextSelection.fromPosition(
      TextPosition(affinity: TextAffinity.downstream, offset: content.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    var focusNode = FocusNode();
    FocusScope.of(context).requestFocus(focusNode);
    return RawKeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKey: (RawKeyEvent event) => print('event: $event'),
      // onKey: (event) {
      //   print('event.runtimeType: ${event.runtimeType}');
      //   if (event.runtimeType == RawKeyDownEvent) {
      //     int keyCode = getKeyCode(event);
      //     print("keyCode: $keyCode");
      //     if (keyCode == 40) {
      //       widget.handleEnter();
      //     }
      //   }
      // },
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'idea',
        ),
        maxLines: 1,
        cursorColor: Colors.orange,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        controller: controller,
        onChanged: (e) {
          if (e.endsWith('\n')) {
            String title = e.substring(0, e.length - 1);
            setTextFieldValue(title);
            widget.updateFn(title);
          } else {
            widget.updateFn(e);
          }
        },
        onEditingComplete: () {},
      ),
    );
  }
}
