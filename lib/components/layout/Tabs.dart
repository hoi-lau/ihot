import 'package:flutter/material.dart';

class Tabs extends StatelessWidget {
  final List<Tab> tabList = <Tab>[
    const Tab(text: 'left'),
    const Tab(text: 'right'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: const Text('data'),
    );
  }
}
