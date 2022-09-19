import 'package:flutter/material.dart';

class TaskLabelList extends StatefulWidget {
  const TaskLabelList({Key? key, required this.dataList}) : super(key: key);

  final List<int> dataList;

  @override
  State<StatefulWidget> createState() {
    return _TaskLabelListState();
  }
}

class _TaskLabelListState extends State<TaskLabelList> {
  @override
  Widget build(BuildContext context) {
    final list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    list.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    list.addAll([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    return SingleChildScrollView(
      child: Column(
        children: list
            .map(
              (e) => Container(
                // key: Key('$e'),
                child: Text('$e'),
              ),
            )
            .toList(),
      ),
    );
  }
}

class TaskLabel extends StatefulWidget {
  const TaskLabel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TaskLabelState();
  }
}

class _TaskLabelState extends State<TaskLabel> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
