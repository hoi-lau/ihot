import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/index.dart';

class TitleEditor extends StatefulWidget {
  const TitleEditor({Key? key, required this.title, required this.updateFn}) : super(key: key);

  final String title;

  final Function updateFn;

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
    _controller.addListener(() {});
  }

  final TextEditingController _controller = TextEditingController(text: '');

  void setTextFieldValue(String content) {
    _controller.text = content;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(affinity: TextAffinity.downstream, offset: content.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(() {});
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (event) {
        if (event.runtimeType == RawKeyDownEvent) {
          int keyCode = getKeyCode(event);
          print("keyCode: $keyCode");
          if (keyCode == 40) {
            print(keyCode);
          }
        }
      },
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        maxLines: null,
        inputFormatters: [],
        cursorColor: Colors.orange,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        controller: _controller,
        onChanged: (e) {
          if (e.endsWith('\n')) {
            String title = e.substring(0, e.length - 1);
            setTextFieldValue(title);
            widget.updateFn(title);
            return;
          }
          widget.updateFn(e);
        },
      ),
    );
  }
}
