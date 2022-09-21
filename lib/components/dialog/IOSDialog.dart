import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IOSStyleDialog extends StatefulWidget {
  const IOSStyleDialog({
    Key? key,
    required this.context,
    required this.title,
    required this.confirmTxt,
    required this.onTap,
    this.confirmColor,
    this.text,
    this.body,
    this.updateFn,
    this.cancelCallback,
  }) : super(key: key);

  final BuildContext context;
  final String title;
  final String confirmTxt;
  final Future<bool> Function() onTap;
  final Color? confirmColor;
  final String? text;
  final Widget? body;
  final Function(BuildContext, void Function(void Function()))? updateFn;
  final Function(BuildContext)? cancelCallback;

  @override
  State<StatefulWidget> createState() {
    return _IOSStyleDialogState();
  }
}

class _IOSStyleDialogState extends State<IOSStyleDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: SingleChildScrollView(
          child: widget.body ?? Text(widget.text!),
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          child: const Text(
            '取消',
          ),
          onPressed: () {
            widget.cancelCallback!(context);
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          onPressed: () {
            widget.onTap().then((value) {
              if (value) {
                Navigator.of(context).pop();
              }
            });
          },
          child: Text(
            widget.confirmTxt,
            style: TextStyle(color: widget.confirmColor ?? Colors.red),
          ),
        ),
      ],
    );
  }
}

Future<void> showIOSStyleDialog({
  required BuildContext context,
  required String title,
  required String confirmTxt,
  required GestureTapCallback onTap,
  Color? confirmColor,
  String? text,
}) async {
  return showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            child: Text(text!),
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
