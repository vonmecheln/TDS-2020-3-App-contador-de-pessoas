import 'package:sqflite/sqflite.dart';
import 'package:test_dados/data.dart';
import 'package:path/path.dart';

class SqlitePersistence implements PersistenceData {
  Database? database;

  _open() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'DATA2.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dados(id INTEGER PRIMARY KEY, data TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future<String> load() async {
    await _open();
    final db = await database;
    String retorno = '';

    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query(
        'dados',
        columns: ['data'],
        where: 'id = ?',
        whereArgs: [1],
      );

      if (maps.length > 0) {
        retorno = maps[0]['name'];
      }
    }

    return retorno;
  }

  @override
  Future<void> save(String data) async {
    await _open();
    final db = await database;

    var value = {'id': 1, 'data': data};

    if (db != null)
      await db.insert(
        'dados',
        value,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
  }
}
