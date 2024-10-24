import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Work.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('Work2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''CREATE TABLE $tableWork (
      ${WorkFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${WorkFields.workName} TEXT NOT NULL,
      ${WorkFields.companyName} TEXT NOT NULL
    )''');
  }

  Future<Work> create(Work work) async {
    final db = await instance.database;
    final id = await db.insert(tableWork, work.toJson());
    return work.copy(id: id);
  }

  Future<Work> readWork(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWork,
      columns: WorkFields.values,
      where: '${WorkFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Work.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Work>> readAllWork() async {
    final db = await instance.database;
    final result = await db.query(tableWork);
    return result.map((json) => Work.fromJson(json)).toList();
  }

  Future<int> update(Work Work) async {
    final db = await instance.database;
    return db.update(
      tableWork,
      Work.toJson(),
      where: '${WorkFields.id} = ?',
      whereArgs: [Work.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      tableWork,
      where: '${WorkFields.id} = ?',
      whereArgs: [id],
    );
  }
}
