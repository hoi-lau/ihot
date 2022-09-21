import 'dart:async';

import 'package:app/utils/EvenBus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../utils/index.dart';
import './Desktop.dart';
import './Mobile.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer> {
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result);
      bus.emit('network', result == ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile()) {
      return const MobileAppContainer();
    }
    return const DesktopAppContainer();
  }
}
