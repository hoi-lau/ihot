import 'package:app/data/database/index.dart';
import 'package:app/data/model/Home.dart';

const String taskLabelName = 'task_label';
const String taskName = 'task';

Future<List<TaskLabelModel>> queryLabelList() async {
  var res = await dbHelper.db.rawQuery('''
    SELECT `tl`.`id` as id, `tl`.`title` as title, ifnull(total,0) as task_count FROM `task_label` `tl` LEFT JOIN (SELECT count(*) as total, `t`.`label` as label FROM `task` `t` GROUP BY `t`.`label`) `tmp` ON tmp.label=`tl`.`id` ORDER BY `tl`.`create_time` ASC
  ''');
  return res.map((element) => TaskLabelModel.fromMap(element)).toList();
}

Future<void> addTaskLabel(TaskLabelModel label) async {
  var map = TaskLabelModel.toMapWithoutCount(label);
  map['create_time'] = DateTime.now().millisecondsSinceEpoch;
  await dbHelper.db.insert(taskLabelName, map);
  return;
}

Future<void> updateTaskLabel(TaskLabelModel label) async {
  var map = TaskLabelModel.toMapWithoutCount(label);
  // map['create_time'] = DateTime.now().millisecondsSinceEpoch;
  await dbHelper.db
      .update(taskLabelName, map, where: 'id = ?', whereArgs: [label.id]);
  return;
}

Future<void> delTaskLabel(TaskLabelModel label) async {
  await dbHelper.db
      .delete(taskLabelName, where: 'id = ?', whereArgs: [label.id]);
  return;
}
