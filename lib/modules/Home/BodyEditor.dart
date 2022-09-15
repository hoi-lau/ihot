import 'package:flutter/material.dart';

class BodyEditor extends StatefulWidget {
  BodyEditor({Key? key, required this.content, required this.updateFn}) : super(key: key);

  String content;

  Function updateFn;

  @override
  State<StatefulWidget> createState() {
    return BodyEditorState();
  }
}

GlobalKey<BodyEditorState> bodyEditorKey = GlobalKey();

class BodyEditorState extends State<BodyEditor> {
  final GlobalKey _newContentKey = GlobalKey();
  final FocusNode _textFieldFocus = FocusNode();

  void setTextFieldValue(String content) {
    (_newContentKey.currentWidget as TextField).controller?.text = content;
  }

  void setEditorFocus() {
    FocusScope.of(context).requestFocus(_textFieldFocus);     // 获取焦点
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: _newContentKey,
      focusNode: _textFieldFocus,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      maxLines: null,
      cursorColor: Colors.orange,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      controller: TextEditingController.fromValue(
        TextEditingValue(
          text: widget.content,
          selection: TextSelection.fromPosition(
            TextPosition(affinity: TextAffinity.downstream, offset: widget.content.length),
          ),
        ),
      ),
      onChanged: (e) {
        if (e.endsWith('\n')) {
          String title = e.substring(0, e.length - 1);
          setTextFieldValue(title);
          widget.updateFn(title);
          return;
        }
        widget.updateFn(e);
      },
    );
  }
}
