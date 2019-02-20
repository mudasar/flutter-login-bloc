import 'package:login_bloc/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:login_bloc/src/models/item_model.dart';

final String _items_table = 'Items';

class NewsDbProvider implements Source, Cache {
  
  Database db;

  NewsDbProvider(){
    init();
  }

 void init() async{
    Directory documentsDirectory =await getApplicationDocumentsDirectory();
    final path =join(documentsDirectory.path, "items.db");
    db =await openDatabase(path, version: 1, onCreate: (Database newdb, version) {
      newdb.execute("""
        CREATE TABLE $_items_table
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTERGER
        );
      """);
      newdb.setVersion(version);

    });
  }

Future<ItemModel>  fetchItem (int id) async {
    if (db.isOpen) {
      final maps = await db.query('$_items_table', columns: null, where: 'id = ?', whereArgs: [id]);
      if (maps.length > 0) {
        return ItemModel.fromDb(maps[0]);
      }
      return null;
    }
    return null;
  }

  Future<int>  addItem(ItemModel item) {
      return db.insert('$_items_table', item.toMap());
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    return null;
  }

}

final newsDbProvider =NewsDbProvider();