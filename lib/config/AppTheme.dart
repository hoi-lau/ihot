import 'package:flutter/material.dart';
import '../utils/index.dart';

class PageTheme {
  PageTheme(this._bgColor, this._fontColor);

  final Color _bgColor;

  final Color _fontColor;

  Color getBgColor() {
    return _bgColor;
  }

  Color getFontColor() {
    return _fontColor;
  }
}

class AppTheme {
  late PageTheme homeTheme;

  AppTheme() {
    if (isMobile()) {
      homeTheme = PageTheme(Colors.white, Colors.orange);
      return;
    }
    homeTheme = PageTheme(const Color.fromRGBO(0, 0, 0, 0.6), Colors.orange);
  }
}

AppTheme appTheme = AppTheme();
