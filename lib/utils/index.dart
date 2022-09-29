import 'dart:async';
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
  var image = await boundary.toImage();
  ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
  completer.complete(byteData?.buffer.asUint8List());
  return completer.future;
}

/// Creates an image from the given widget by first spinning up a element and render tree,
/// then waiting for the given [wait] amount of time and then creating an image via a [RepaintBoundary].
///
/// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
Future<Uint8List> createImageFromWidget(Widget? widget) async {
  assert(widget != null);
  final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

  final Size logicalSize = window.physicalSize / window.devicePixelRatio;
  final Size imageSize = window.physicalSize;

  assert(logicalSize.aspectRatio == imageSize.aspectRatio);

  final RenderView renderView = RenderView(
    window: window,
    child: RenderPositionedBox(
        alignment: Alignment.center, child: repaintBoundary),
    configuration: ViewConfiguration(
      size: logicalSize,
      devicePixelRatio: 1.0,
    ),
  );

  final PipelineOwner pipelineOwner = PipelineOwner();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

  pipelineOwner.rootNode = renderView;
  renderView.prepareInitialFrame();

  final RenderObjectToWidgetElement<RenderBox> rootElement =
      RenderObjectToWidgetAdapter<RenderBox>(
    container: repaintBoundary,
    child: widget,
  ).attachToRenderTree(buildOwner);

  buildOwner.buildScope(rootElement);

  // if (wait != null) {
  await Future.delayed(const Duration(milliseconds: 150));
  // }

  buildOwner.buildScope(rootElement);
  buildOwner.finalizeTree();

  pipelineOwner.flushLayout();
  pipelineOwner.flushCompositingBits();
  pipelineOwner.flushPaint();

  var image = await repaintBoundary.toImage(
      pixelRatio: imageSize.width / logicalSize.width);
  var byteData =
      (await image.toByteData(format: ImageByteFormat.png)) as ByteData;
  print(byteData);
  return byteData.buffer.asUint8List();
}

/// nmb > 0
String thousandSeparate(int nmb) {
  var origin = '$nmb';
  if (nmb < 1000) return origin;
  var res = '';
  for (var i = origin.length; i > 0;) {
    i = i - 3;
    if (i < 0) {
      res = '${origin.substring(0, i + 3)},$res';
      break;
    }
    res = '${origin.substring(i, i + 3)},$res';
  }
  return res.substring(0, res.length - 1);
}