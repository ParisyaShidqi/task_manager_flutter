import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager_flutter/core/model/TaskCardModel.dart';

Future<void> updateTaskCard(TaskCardModel taskCardModel) async {
  // Get a reference to the database.
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'task_manager_db.db');
  final db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      db.execute(
          'CREATE TABLE task_card( title TEXT, description TEXT, duedate TEXT, status TEXT, type TEXT, id INTEGER PRIMARY KEY AUTOINCREMENT)');
    },
  );

  // Insert the task card into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same task card is inserted twice.
  //
  // In this case, replace any previous data.
  await db.update(
    'task_card',
    taskCardModel.toJson(),
    where: 'id = ?',
    whereArgs: [taskCardModel.id],
  );
}
