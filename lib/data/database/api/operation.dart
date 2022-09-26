enum OperationType { ADD, UPDATE, DELETE }

class BaseOperation {

  BaseOperation({required this.tableName, required this.operationType, this.params});

  String tableName;

  Map<String, Object?>? params;

  OperationType operationType;
}
