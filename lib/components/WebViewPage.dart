import 'dart:convert';

import 'package:app/routes/index.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String url;
  String title = '';
  final bool isLocalUrl;

  late WebViewController _webViewController;

  WebViewPage(
      {Key? key, required this.url, this.isLocalUrl = false, this.title = ''})
      : super(key: key);

  @override
  _WebViewPage createState() => _WebViewPage();
}

class _WebViewPage extends State<WebViewPage> {
  JavascriptChannel jsBridge(BuildContext context) => JavascriptChannel(
      name: 'jsbridge', // 与h5 端的一致 不然收不到消息
      onMessageReceived: (JavascriptMessage message) async {
        debugPrint(message.message);
      });

  @override
  Widget build(BuildContext context) {
    // return Scaffold(appBar: _buildAppbar(), body: _buildBody());
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Scaffold(
          // backgroundColor: const Color(0x00ccd0d7),
          appBar: _buildAppbar(),
          body: _buildBody(),
        ),
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color(0x00ccd0d7),
      toolbarHeight: 48,
      title: Text(
        widget.title,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.blueAccent,
        ),
        onPressed: () {
          MyRouter.pop(context);
        },
      ),
    );
  }

  _buildBody() {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 1,
          width: double.infinity,
          child:
              DecoratedBox(decoration: BoxDecoration(color: Color(0xFFEEEEEE))),
        ),
        Expanded(
          flex: 1,
          child: WebView(
            initialUrl: widget.isLocalUrl
                ? Uri.dataFromString(widget.url,
                        mimeType: 'text/html',
                        encoding: Encoding.getByName('utf-8'))
                    .toString()
                : widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            // javascriptChannels: <JavascriptChannel>[jsBridge(context)].toSet(),
            onWebViewCreated: (WebViewController controller) {
              widget._webViewController = controller;
              if (widget.isLocalUrl) {
                // _loadHtmlAssets(controller);
              } else {
                controller.loadUrl(widget.url);
              }
              controller
                  .canGoBack()
                  .then((value) => debugPrint(value.toString()));
              controller
                  .canGoForward()
                  .then((value) => debugPrint(value.toString()));
              controller.currentUrl().then((value) => debugPrint(value));
            },
            onPageFinished: (String value) {
              widget._webViewController
                  .evaluateJavascript('document.title')
                  .then((title) {
                setState(() {
                  widget.title = title;
                });
                debugPrint(title);
              });
            },
          ),
        )
      ],
    );
  }

//  加载本地文件
//   _loadHtmlAssets(WebViewController controller) async {
//     String htmlPath = await rootBundle.loadString(widget.url);
//     controller.loadUrl(Uri.dataFromString(htmlPath,
//             mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//         .toString());
//   }
}
