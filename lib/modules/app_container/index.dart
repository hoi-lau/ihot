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
  @override
  Widget build(BuildContext context) {
    if (isMobile()) {
      return const MobileAppContainer();
    }
    return const DesktopAppContainer();
  }
}
