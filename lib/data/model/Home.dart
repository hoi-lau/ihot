import 'dart:convert';

class TaskLabelModel {
  int? id;
  String title;
  int? task_count;

  TaskLabelModel({this.id, required this.title, this.task_count});

  static TaskLabelModel fromMap(Map<String, dynamic> map) {
    return TaskLabelModel(
        id: map['id'], title: map['title'], task_count: map['task_count']);
  }

  static Map<String, dynamic> toMap(TaskLabelModel label) {
    return <String, dynamic>{
      "id": label.id,
      "title": label.title,
      'task_count': label.task_count
    };
  }

  static TaskLabelModel fromJsonString(String str) {
    var obj = json.decode(str);
    var res = TaskLabelModel(
        title: obj['title'], id: obj['id'], task_count: obj['task_count']);
    return res;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['task_count'] = task_count;
    return _data;
  }
}
