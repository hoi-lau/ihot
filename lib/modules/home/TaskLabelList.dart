import 'package:app/data/model/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../config/AppTheme.dart';

class TaskLabelList extends StatefulWidget {
  const TaskLabelList({
    Key? key,
    required this.dataList,
    required this.handleLabelDel,
    required this.handleLabelEdit,
  }) : super(key: key);

  final List<TaskLabelModel> dataList;

  final Function handleLabelDel;

  final Function handleLabelEdit;

  @override
  State<StatefulWidget> createState() {
    return _TaskLabelListState();
  }
}

class _TaskLabelListState extends State<TaskLabelList> {
  bool showEditActions(int index) {
    if ([0, 1].contains(index)) return false;
    if (index == widget.dataList.length - 1) return false;
    return true;
  }

  Widget getLabelIcon(int index) {
    Widget res;

    switch (index) {
      case 0:
        res = Icon(
          Icons.task_alt_sharp,
          color: appTheme.homeTheme.getFontColor(),
          size: 18,
        );
        break;
      case 1:
        res = Icon(
          Icons.history,
          color: appTheme.homeTheme.getFontColor(),
          size: 18,
        );
        break;
      default:
        res = Icon(
          Icons.label_important_outline_rounded,
          color: appTheme.homeTheme.getFontColor(),
          size: 18,
        );
    }
    if (index == widget.dataList.length - 1) {
      return Icon(
        Icons.delete_forever,
        color: appTheme.homeTheme.getFontColor(),
        size: 18,
      );
    }

    return res;
  }

  Widget _buildTaskLabel(int index) {
    var content = Row(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 8),
          width: 26,
          child: getLabelIcon(index),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.dataList[index].title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                ),
                child: Text(
                  '${widget.dataList[index].task_count}',
                  style: TextStyle(
                    color: appTheme.gray,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: appTheme.gray,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
    return Container(
      key: Key('${widget.dataList[index].id}'),
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          showEditActions(index)
              ? Slidable(
                  key: Key('${widget.dataList[index].id}'),
                  closeOnScroll: false,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.5,
                    children: [
                      CustomSlidableAction(
                        onPressed: (e) {
                          widget.handleLabelEdit(index);
                        },
                        backgroundColor: const Color.fromRGBO(47, 132, 227, 1),
                        child: Icon(
                          Icons.edit_note,
                          color: appTheme.white,
                        ),
                      ),
                      CustomSlidableAction(
                        onPressed: (e) {
                          widget.handleLabelDel(index);
                        },
                        backgroundColor: appTheme.danger,
                        child: Icon(
                          Icons.delete_forever,
                          color: appTheme.white,
                        ),
                      ),
                    ],
                  ),
                  child: content,
                )
              : content,
          index < widget.dataList.length - 1
              ? Container(
                  height: 1,
                  margin: const EdgeInsets.only(left: 26),
                  color: const Color.fromRGBO(209, 209, 210, 1),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: ReorderableListView.builder(
              itemCount: widget.dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Material(
                  color: Colors.transparent,
                  key: Key('${widget.dataList[index].id}'),
                  child: Ink(
                    color: appTheme.white,
                    child: InkWell(
                      child: _buildTaskLabel(index),
                      onTap: () {},
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              onReorder: (int oldIndex, int newIndex) {},
            ),
          ),
        ),
      ],
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
