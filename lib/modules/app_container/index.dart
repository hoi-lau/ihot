import 'dart:async';

import 'package:app/data/database/index.dart';
import 'package:app/utils/EvenBus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../utils/SharedPrefs.dart';
import '../../utils/index.dart';
import './Desktop.dart';
import './Mobile.dart';

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
      return _mounted ? const MobileAppContainer() : Container();
    }
    return const DesktopAppContainer();
  }
}
