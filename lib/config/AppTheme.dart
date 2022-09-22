import 'package:flutter/material.dart';
import '../utils/index.dart';

class WidgetTheme {
  WidgetTheme(this._bgColor, this._fontColor);

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
  late WidgetTheme homeTheme;

  late WidgetTheme searchTheme;

  final Color danger = const Color.fromRGBO(252, 62, 48, 1);

  final Color white = Colors.white;

  final Color black = Colors.black;

  final Color appleBlue = const Color.fromRGBO(0, 122, 255, 1);

  final Color gray = const Color.fromRGBO(138, 137, 142, 1);

  AppTheme() {
    if (isMobile()) {
      homeTheme = WidgetTheme(const Color.fromRGBO(241, 242, 246, 1),
          const Color.fromRGBO(226, 166, 0, 1));
      // homeTheme =
      //     WidgetTheme(const Color.fromRGBO(255, 255, 255, 1), Colors.orange);
      searchTheme = WidgetTheme(const Color.fromRGBO(227, 227, 232, 1),
          const Color.fromRGBO(126, 127, 133, 1));
      return;
    }
    homeTheme = WidgetTheme(const Color.fromRGBO(0, 0, 0, 0.6), Colors.orange);
    searchTheme =
        WidgetTheme(const Color.fromRGBO(255, 255, 255, 1), Colors.orange);
  }
}

AppTheme appTheme = AppTheme();
