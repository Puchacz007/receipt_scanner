import 'dart:io';


import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receipt_scanner/Model/item.dart';
import 'package:receipt_scanner/Model/receipt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'GameMasterCompanion.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE RECEIPT ('
              'ID INTEGER PRIMARY KEY,'
          'SCANNED_DOCUMENT BLOB,'
          'CREATION_DATE INTEGER,'
          'SHOP_NAME TEXT,'
          'TOTAL_PRICE REAL'
              ')');

          await db.execute('CREATE TABLE ITEM ('
              'NAME TEXT,'
              'RECEIPT_ID INTEGER,'
              'PRICE REAL,'
              'QUANTITY INTEGER,'
              'FOREIGN KEY (RECEIPT_ID) REFERENCES RECEIPT(ID),'
              'CONSTRAINT ITEM_PK PRIMARY KEY(NAME,RECEIPT_ID)'
              ')');

        }
        );
  }
  Future<int> getMaxReceiptID() async {
    final Database db = await database;
    final List<Map<String, Object>> res =
    await db.rawQuery('SELECT MAX(ID) as ID FROM RECEIPT');
    if (res.isNotEmpty && res.map((Map<String, Object> e) => e['ID']).first != null)
      return  res.map((Map<String, Object> e) => e['ID']).first as int;
      else return -1;
  }

  Future addItem(Item item)
  async {
    final Database db = await database;

    int res = -1;
    res = await db.insert('ITEM', item.toMap());
    return res;
  }
  Future addReceipt(Receipt receipt)
  async {
    final Database db = await database;

    int res = -1;
    res = await db.insert('RECEIPT', receipt.toMap());
  return res;
  }
  Future<void> deleteReceipt(int receiptID) async {
    final Database db = await database;
    await db.delete('RECEIPT',
        where: 'ID = ?', whereArgs: <Object>[receiptID]);
    await db.delete('ITEM',
        where: 'RECEIPT_ID = ?', whereArgs: <Object>[receiptID]);

  }

  Future getAllReceipts()
  async {
    final Database db = await database;
    List<Map<String, Object>> res = await db.query("RECEIPT");
    final List receiptList = res.isNotEmpty
        ? res.map((Map<String, Object> c) => Receipt.fromMap(c)).toList()
        : <Receipt>[];
    res = await db.query("ITEM");
    final List itemList = res.isNotEmpty
        ? res.map((Map<String, Object> c) => Item.fromMap(c)).toList()
        : <Item>[];
    for (Receipt receipt in receiptList)
    {
      for (Item item in itemList)
      {
        if(item.receiptID == receipt.id)
          receipt.items.add(item);
      }
    }
    return receiptList;
  }
}