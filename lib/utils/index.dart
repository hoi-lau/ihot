import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

bool isMobile() {
  return Platform.isAndroid || Platform.isIOS;
}

int uid = -1;

int getUid() {
  return uid--;
}

int getKeyCode(RawKeyEvent e) {
  int keyCode = 0;
  print('e: $e');
  if (e.data is RawKeyEventDataIos) {
    print('ios');
    RawKeyEventDataIos data = e.data as RawKeyEventDataIos;
    keyCode = data.keyCode;
  } else if (e.data is RawKeyEventDataAndroid) {
    RawKeyEventDataAndroid data = e.data as RawKeyEventDataAndroid;
    keyCode = data.keyCode;
  } else if (e.data is RawKeyEventDataWindows) {
    RawKeyEventDataWindows data = e.data as RawKeyEventDataWindows;
    keyCode = data.keyCode;
  } else if (e.data is RawKeyEventDataMacOs) {
    RawKeyEventDataMacOs data = e.data as RawKeyEventDataMacOs;
    keyCode = data.keyCode;
  }
  return keyCode;
}

void closeKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  // 键盘是否是弹起状态
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
