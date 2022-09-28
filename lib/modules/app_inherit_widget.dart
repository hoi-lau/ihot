import 'package:flutter/material.dart';

class AppInheritWidget extends InheritedWidget {
  const AppInheritWidget(
      {Key? key, required super.child, required this.blackMode})
      : super(key: key);

  final bool blackMode;

  @override
  bool updateShouldNotify(covariant AppInheritWidget oldWidget) {
    return blackMode != oldWidget.blackMode;
  }
}
