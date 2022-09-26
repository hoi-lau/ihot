import 'package:app/config/AppTheme.dart';
import 'package:app/utils/EvenBus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class FaireAppBar extends AppBar {
//   FaireAppBar({Key? key, this.title, this.actions}) : super(key: key);
//
//   final String? title;
//
//   // final List<Widget>? actions;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _FaireAppBarState();
//   }
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => throw UnimplementedError();
// }
//
// class _FaireAppBarState extends State<FaireAppBar> {
//   bool offline = false;
//
//   @override
//   void initState() {
//     super.initState();
//     bus.on('network', (arg) {
//       setState(() {
//         offline = arg;
//       });
//     });
//   }
//
//   @override
//   PreferredSizeWidget build(BuildContext context) {
//     return AppBar(
//       elevation: 0,
//       backgroundColor: appTheme.homeTheme.getBgColor(),
//       toolbarHeight: 36,
//       leading: CupertinoButton(
//         onPressed: () {},
//         child: const Icon(Icons.home),
//       ),
//       title: offline
//           ? Text(
//               'offline',
//               style: TextStyle(color: appTheme.homeTheme.getFontColor()),
//             )
//           : null,
//       actions: widget.actions,
//     );
//   }
// }

AppBar faireAppBar({Widget? title, List<Widget>? actions}) {
  bool offline = false;
  bus.on('network', (arg) {
    offline = arg;
  });
  return AppBar(
    elevation: 0,
    backgroundColor: appTheme.homeTheme.getBgColor(),
    toolbarHeight: 42,
    leading: CupertinoButton(
      onPressed: () {
        bus.emit('page-change', 0);
      },
      padding: const EdgeInsets.all(0.0),
      child:  Icon(Icons.list, color: appTheme.gray,),
    ),
    title: title ??
        (offline
            ? Text(
                'offline',
                style: TextStyle(color: appTheme.homeTheme.getFontColor()),
              )
            : null),
    actions: actions,
  );
}
