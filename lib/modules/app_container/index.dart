import 'dart:async';

import 'package:app/data/database/index.dart';
import 'package:app/modules/app_container/Desktop.dart';
import 'package:app/modules/app_container/Mobile.dart';
import 'package:app/modules/home/index.dart';
import 'package:app/utils/EvenBus.dart';
import 'package:app/utils/SharedPrefs.dart';
import 'package:app/utils/index.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<StatefulWidget> createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer> {
  late StreamSubscription subscription;

  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    beforeMounted();
  }

  Future<void> beforeMounted() async {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);
      bus.emit('network', result == ConnectivityResult.none);
    });
    await sharedPrefsUtils.initSharedPref();
    await dbHelper.initDBHelper();
    // await
    _mounted = true;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile()) {
      return _mounted
          ? MobileAppContainer(
              child: widget.child ?? const Home(),
            )
          : Container();
    }
    return const DesktopAppContainer();
  }
}
