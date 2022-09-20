import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showIOSStyleDialog({
  required BuildContext context,
  required String title,
  required String confirmTxt,
  required GestureTapCallback onTap,
  Color? confirmColor,
  String? text,
  Widget? body,
}) async {
  return showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) {
      assert(body != null || text != null);
      return CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: body ?? Text(text!),
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text(
              '取消',
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            onPressed: onTap,
            child: Text(
              confirmTxt,
              style: TextStyle(color: confirmColor ?? Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
