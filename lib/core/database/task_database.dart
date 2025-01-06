import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_flutter/core/model/TaskCardModel.dart';

Future<List<TaskCardModel>> showTaskCard({int? id}) async {
  // Get a reference to the database.
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'task_manager_db.db');
  final db =
      await openDatabase(path, version: 1, onCreate: (db, version) async {
    db.execute(
        'CREATE TABLE task_card( title TEXT, description TEXT, duedate TEXT, status TEXT, type TEXT, id INTEGER PRIMARY KEY AUTOINCREMENT)');
  });

  // Query the table for all the task card.
  final List<Map<String, Object?>> cashflowMap = await db.query(
    'task_card',
    where: id == null ? null : 'id = ?',
    whereArgs: id == null ? null : [id],
  );

  // Convert the list of each task's fields into a list of `Task` objects.
  return [
    for (final {
          'id': id as int,
          'title': title as String,
          'description': description as String,
          'duedate': duedate as String,
          'status': status as String,
          'type': type as String,
        } in cashflowMap)
      TaskCardModel(
          id: id,
          title: title,
          description: description,
          duedate: DateTime.parse(duedate),
          status: status,
          type: type)
  ];
}
