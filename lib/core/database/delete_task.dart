import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager_flutter/core/model/TaskCardModel.dart';

Future<void> deleteTaskCard(int id) async {
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
  await db.delete(
    'task_card',
    // Use a `where` clause to delete a specific Task.
    where: 'id = ?',
    // Pass the Task's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}
