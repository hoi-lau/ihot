import 'package:app/data/model/Home.dart';
import 'package:app/fetch/HttpUtils.dart';

Http http = Http();

Future<List<TaskLabelModel>> fetchLabelList() async {
  var list = await http.get<List<dynamic>>('/task_label/list');
  return list.map((element) => TaskLabelModel.fromMap(element)).toList();
}

Future<void> updateLabel(TaskLabelModel data) async {
  await http.post<void>('/task_label/update', data: TaskLabelModel.toMap(data));
}

Future<void> addLabel(TaskLabelModel data) async {
  await http.post<void>('/task_label/add', data: TaskLabelModel.toMap(data));
}

Future<void> delLabel(TaskLabelModel data) async {
  await http.post<void>('/task_label/del', data: TaskLabelModel.toMap(data));
}
