class TaskLabelModel {
  int? id;
  String title;

  TaskLabelModel(this.id, this.title);

  static TaskLabelModel fromMap(Map<String, dynamic> map) {
    return TaskLabelModel(map['id'], map['title']);
  }
}
