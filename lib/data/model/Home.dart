import 'dart:convert';

class TaskLabelModel {
  int? id;
  String title;

  TaskLabelModel({this.id, required this.title});

  static TaskLabelModel fromMap(Map<String, dynamic> map) {
    return TaskLabelModel(id: map['id'], title: map['title']);
  }

  static Map<String, dynamic> toMap(TaskLabelModel label) {
    return <String, dynamic>{"id": label.id, "title": label.title};
  }

  static TaskLabelModel fromJsonString(String str) {
    var obj = json.decode(str);
    var res = TaskLabelModel(title: obj['title'], id: obj['id']);
    return res;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    return _data;
  }
}
