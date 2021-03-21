import 'package:service_search_app/models/search_result.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'service_shema.db'),
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE products (
        id int PRIMARY KEY,
        name varchar(255),
        description varchar(255),
        ranking int
      );
            ''');
      await db.execute('''
      CREATE TABLE food (
        id_food int PRIMARY KEY,
        id_product int
      );
      ALTER TABLE food ADD FOREIGN KEY (id_product) REFERENCES products (id);
      ''');
      await db.execute('''
      CREATE TABLE music (
        id_music int PRIMARY KEY,
        id_product int
      );
      ALTER TABLE music ADD FOREIGN KEY (id_product) REFERENCES products (id);
      ''');

      await db.execute('''
      CREATE TABLE place (
        id_place int PRIMARY KEY,
        id_product int
      );
      ALTER TABLE place ADD FOREIGN KEY (id_product) REFERENCES products (id);
      ''');

      //Fill db with dummys
      var batch = db.batch();
      batch.insert('products', {
        'id': 1,
        'name': "Starbucks",
        'description': "Starbucks center for coffe",
        'ranking': 7
      });
      batch.insert('products', {
        'id': 2,
        'name': "McDonalds",
        'description': "Para papa pa!",
        'ranking': 8
      });
      batch.insert('products', {
        'id': 3,
        'name': "StarFood",
        'description': "Incredible star food",
        'ranking': 9
      });
      batch.insert('products', {
        'id': 4,
        'name': "BurgerKing",
        'description': "Better than McDonalds",
        'ranking': 10
      });
      batch.insert('products', {
        'id': 5,
        'name': "FatRat",
        'description': "American artist",
        'ranking': 8
      });
      batch.insert('products', {
        'id': 6,
        'name': "Avicii",
        'description': "Swedish artist",
        'ranking': 10
      });
      batch.insert('products', {
        'id': 7,
        'name': "LonelyIsland",
        'description': "Parody Artist",
        'ranking': 3
      });
      batch.insert('products', {
        'id': 8,
        'name': "The Eagles",
        'description': "Hotel california band",
        'ranking': 5
      });

      batch.insert('products', {
        'id': 9,
        'name': "New York",
        'description': "American text here",
        'ranking': 10
      });
      batch.insert('products', {
        'id': 10,
        'name': "Hampshire",
        'description': "British text here",
        'ranking': 7
      });
      batch.insert('products', {
        'id': 11,
        'name': "New Jersey",
        'description': "You know why",
        'ranking': 2
      });
      batch.insert('products', {
        'id': 12,
        'name': "Merida",
        'description': "Now with more cases of covid",
        'ranking': 10
      });

      //Insert data to food table
      batch.insert('food', {'id_food': 1, 'id_product': 1});
      batch.insert('food', {'id_food': 2, 'id_product': 2});
      batch.insert('food', {'id_food': 3, 'id_product': 3});
      batch.insert('food', {'id_food': 4, 'id_product': 4});
      //Insert data to music table
      batch.insert('music', {'id_music': 1, 'id_product': 5});
      batch.insert('music', {'id_music': 2, 'id_product': 6});
      batch.insert('music', {'id_music': 3, 'id_product': 7});
      batch.insert('music', {'id_music': 4, 'id_product': 8});
      //Insert data to place table
      batch.insert('place', {'id_place': 1, 'id_product': 9});
      batch.insert('place', {'id_place': 2, 'id_product': 10});
      batch.insert('place', {'id_place': 3, 'id_product': 11});
      batch.insert('place', {'id_place': 4, 'id_product': 12});

      batch.commit();
    }, version: 2);
  }

  Future<List<SearchResult>> getAllFoodByName(String name) async {
    final db = await database;
    List<SearchResult> results = [];
    var queryResults = await db.rawQuery(
        "SELECT * FROM products INNER JOIN food ON products.id = food.id_product WHERE products.name LIKE '%$name%'");
    if (queryResults.length != null) {
      queryResults.forEach((element) {
        results.add(SearchResult.fromJson(element));
      });
    }
    return results;
  }

  Future<List<SearchResult>> getAllMusicByName(String name) async {
    final db = await database;
    List<SearchResult> results = [];
    var queryResults = await db.rawQuery(
        "SELECT * FROM products INNER JOIN music ON products.id = music.id_product WHERE products.name LIKE '%$name%'");
    if (queryResults.length != null) {
      queryResults.forEach((element) {
        results.add(SearchResult.fromJson(element));
      });
    }
    return results;
  }

  Future<List<SearchResult>> getAllPlaceByName(String name) async {
    final db = await database;
    List<SearchResult> results = [];
    var queryResults = await db.rawQuery(
        "SELECT * FROM products INNER JOIN place ON products.id = place.id_product WHERE products.name LIKE '%$name%'");
    if (queryResults.length != null) {
      queryResults.forEach((element) {
        results.add(SearchResult.fromJson(element));
      });
    }
    return results;
  }
}
