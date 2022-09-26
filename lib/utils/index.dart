import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

bool isMobile() {
  return Platform.isAndroid || Platform.isIOS;
}

int getKeyCode(RawKeyEvent e) {
  int keyCode = 0;
  if (e.data is RawKeyEventDataIos) {
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

/// Widget 转 图片
Future<Uint8List> widgetToImage(GlobalKey _globalKey) async {
  Completer<Uint8List> completer = Completer();
  RenderRepaintBoundary boundary =
      _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  if (boundary.debugNeedsPaint) {
    print('object');
    // return Future.delayed(const Duration(milliseconds: 1000), () => widgetToImage(_globalKey));
  }
  var image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
  completer.complete(byteData?.buffer.asUint8List());
  return completer.future;
}
