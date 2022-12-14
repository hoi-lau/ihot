import 'package:app/modules/app_overview/index.dart';
import 'package:app/modules/base64_page/index.dart';
import 'package:flutter/material.dart';

import '../home/index.dart';
import '../search_page/index.dart';

class IconItem {
  String label;

  Icon activeIcon;

  Icon normalIcon;

  IconItem(this.label, this.activeIcon, this.normalIcon);
}

List<IconItem> items = [
  IconItem(
      '',
      const Icon(Icons.home, color: Colors.orange),
      const Icon(
        Icons.home,
        color: Colors.black38,
      )),
  IconItem(
      '',
      const Icon(Icons.list, color: Colors.orange),
      const Icon(
        Icons.list,
        color: Colors.black38,
      )),
];

List<Widget> outsidePages = [
  const AppOverview(),
  const Home(),
  // const SearchPage(),
  const Base64Page()
];

List<String> outsideHero = ['home-page', 'base64-page'];
List<BottomNavigationBarItem> itemList = items
    .map((e) => BottomNavigationBarItem(
        icon: e.normalIcon, activeIcon: e.activeIcon, label: e.label))
    .toList();
