import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteService
{
  Database? _db;
  static const _dbName = 'scanner';

  //private constructor of class
  SQLiteService._privateConstructor();
  static final SQLiteService instance = SQLiteService._privateConstructor();

  Future<Database> get db async
  {
    _db ??= await initDB();
    return _db!;
  }

  initDB() async
  {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path,version: 2, onCreate: _onCreate);
  }




  _onCreate(Database db, int version) async
  {
    await db.execute(
        '''
        Create Table  IF NOT EXISTS History(
        id Integer primary key autoincrement,
        title Text,
        data Text,
        type Text,
        category Text,
        date Integer
        );
      '''
    );
  }


  Future<int> rawInsert({required String query}) async
  {
    Database database = await instance.db;
    int id = await database.rawInsert(query);
    return id;
  }



  Future<int> rawUpdate({required String query}) async
  {
    Database database = await instance.db;
    int id = await database.rawUpdate(query);
    return id;
  }


  Future<int> rawDelete({required String query}) async
  {
    Database database = await instance.db;
    int id = await database.rawDelete(query);
    return id;
  }


  Future<List<Map<String, Object?>>> rawQuery({required String query}) async
  {
    Database database = await instance.db;
    var id = await database.rawQuery(query);
    return id;
  }

  Future<Map<String, Object?>?> getOneRow({required String query}) async
  {
    Database database = await instance.db;
    var id = await database.rawQuery(query);
    if(id.isNotEmpty)
      {
        return id.first;
      }
    else
      {
        return null;
      }
  }


  Future<bool> checkExists({required String query}) async
  {
   bool x = false;
    Database database = await instance.db;
    var data = await database.rawQuery(query);
    if(data.isNotEmpty)
    {
      x = true;
    }
    return x;
  }

}