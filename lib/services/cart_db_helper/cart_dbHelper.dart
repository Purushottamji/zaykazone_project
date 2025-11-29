import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/cart_modal/cart_modal.dart';


class CartDB {
  static final CartDB instance = CartDB._init();
  static Database? _database;

  CartDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE cart(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      image TEXT,
      price REAL,
      quantity INTEGER
    )
    ''');
  }


  Future<int> insertCart(CartModel data) async {
    final db = await instance.database;
    return await db.insert('cart', data.toMap());
  }


  Future<List<CartModel>> getCartItems() async {
    final db = await instance.database;
    final result = await db.query('cart');

    return result.map((e) => CartModel.fromMap(e)).toList();
  }

  Future<int> updateCart(CartModel data) async {
    final db = await instance.database;

    return await db.update(
      'cart',
      data.toMap(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
  }


  Future<int> deleteCart(int id) async {
    final db = await instance.database;

    return await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
