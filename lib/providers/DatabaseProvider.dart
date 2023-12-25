import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/Recommendation.dart';

class DatabaseProvider {
  late Database _database;

  Future<void> open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'recommendations.db'),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE recommendations(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, desc TEXT, image TEXT)',
      );
    },
    version: 1,
    );
  }

  Future<void> addRecommendation(Recommendation recommendation) async {
    await _database.insert(
      'recommendations',
      recommendation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeRecommendation(String title) async {
    await _database.delete(
      'recommendations',
      where: 'title = ?',
      whereArgs: [title],
    );
  }

  Future<List<Recommendation>> getRecommendations() async {
    final List<Map<String, dynamic>> maps = await _database.query('recommendations');
    return List.generate(maps.length, (i) {
      return Recommendation(
        title: maps[i]['title'] as String,
        desc: maps[i]['desc'] as String,
        image: maps[i]['image'] as String,
      );
    });
  }
}
