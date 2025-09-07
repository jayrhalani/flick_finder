import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  static final DbService _instance = DbService._internal();
  factory DbService() => _instance;
  DbService._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');
    return await openDatabase(
      path,
      version: 2, // Bump version for migration
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterPath TEXT,
            type TEXT,
            voteAverage REAL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1 && newVersion == 2) {
          await db.execute(
            'ALTER TABLE favorites ADD COLUMN voteAverage REAL;',
          );
        }
      },
    );
  }

  Future<void> addFavorite({
    required int id,
    required String title,
    required String posterPath,
    required String type, // 'movie' or 'tv'
    required double voteAverage,
  }) async {
    final dbClient = await db;
    await dbClient.insert('favorites', {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'type': type,
      'voteAverage': voteAverage,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFavorite(int id) async {
    final dbClient = await db;
    await dbClient.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavorites({String? type}) async {
    final dbClient = await db;
    if (type != null) {
      return await dbClient.query(
        'favorites',
        where: 'type = ?',
        whereArgs: [type],
      );
    }
    return await dbClient.query('favorites');
  }

  Future<bool> isFavorite(int id) async {
    final dbClient = await db;
    final result = await dbClient.query(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }
}
