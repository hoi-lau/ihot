import 'dart:io';

import 'package:flutter/services.dart';

bool isMobile() {
  return Platform.isAndroid || Platform.isIOS;
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
