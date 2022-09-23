import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'pre_execute.dart';

class DBHelper {
  int version = 1;

  late Database db;

  static final DBHelper _instance = DBHelper._internal();

  // 单例模式
  factory DBHelper() => _instance;

  DBHelper._internal() {
    // to do
  }

  Future<void> initDBHelper() async {
    // 获取数据库文件的存储路径
    var databasesPath = await getDatabasesPath();
    String targetPath = join(databasesPath, 'faire.db');
    // bool exists = await databaseExists(targetPath);
    // 根据数据库文件路径和数据库版本号创建数据库表

    db = await openDatabase(
      targetPath,
      version: version,
      onCreate: (Database database, int version) async {
        print('db => onCreate');
      },
      onOpen: (Database database) async {},
    );
    await initBaseData();
    var result = await db.query('task_label');
    print(result);
  }

  Future<void> initBaseData() async {
    for (var i = 0; i < faireSql.length; i++) {
      await db.execute(faireSql[i]);
    }
  }
}

var dbHelper = DBHelper();
