import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('analytikas_db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: _onConfigure,
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const idTypeInc = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const doubleType = 'DOUBLE NOT NULL';

    // 1. Tabel Session User
    await db.execute('''
      CREATE TABLE session_user(
        email $textType,
        token $textType
      )
    ''');

    // 2. Tabel toko
    await db.execute('''
      CREATE TABLE toko(
        id_toko $idType,
        nama_toko $textType,
        email $textType,
        no_telp $textType,
        password $textType,
        alamat $textType
      )
    ''');

    // 3. Tabel Kategori
    await db.execute('''
      CREATE TABLE kategori(
        id_kategori $idTypeInc,
        nama_kategori $textType 
      )
    ''');

    // 4. Tabel harga product
    await db.execute('''
      CREATE TABLE harga_product (
        id_harga $idTypeInc,
        harga_jual $doubleType,
        harga_beli $doubleType,
        satuan $textType,
        jmlh_satuan $intType
      )
    ''');

    // 5. Tabel product
    await db.execute('''
      CREATE TABLE product (
        id_product $intType,
        nama_product $textType,
        jmlh_stok $intType, 
        is_grosir $intType,
        is_active $intType,
        id_kategori $intType,
        id_harga $intType,
        warning_stok $intType,
        PRIMARY KEY (id_product, id_harga),
        FOREIGN KEY (id_kategori) REFERENCES kategori (id_kategory) ON DELETE RESTRICT,
        FOREIGN KEY (id_harga) REFERENCES harga_product (id_harga) ON DELETE RESTRICT
    ''');

    // 6. Tabel penjualan
    await db.execute('''
      CREATE TABLE penjualan (
        id_penjualan $idTypeInc,
        tanggal $textType,
        waktu $textType,
        total_item $intType,
        total_harga $doubleType,
      )
    ''');
    // 7. Tabel pembelian
    await db.execute('''
      CREATE TABLE pembelian (
        id_pembelian $idTypeInc,
        tanggal $textType,
        waktu $textType,
        total_item $intType,
        total_harga $doubleType
      )
    ''');

    // 8. Tabel product per penjualan
    await db.execute('''
      CREATE TABLE product_per_penjualan (
        id_penjualan $intType,
        id_product $intType,
        jumlah $intType,
        PRIMARY KEY (id_penjualan, id_product)
        FOREIGN KEY (id_penjualan) REFERENCES pembelian (id_penjualan) ON DELETE CASCADE,
        FOREIGN KEY (id_product) REFERENCES product (id_product) ON DELETE RESTRICT
      )
    ''');
    // 9. Tabel product per pembelian
    await db.execute('''
      CREATE TABLE product_per_pembelian (
        id_pembelian $intType,
        id_product $intType,
        jumlah $intType,
        PRIMARY KEY (id_pembelian, id_product)
        FOREIGN KEY (id_pembelian) REFERENCES pembelian (id_pembelian) ON DELETE CASCADE,
        FOREIGN KEY (id_product) REFERENCES product (id_product) ON DELETE RESTRICT
      )
    ''');

    // Future close() async {
    //   final db = await instance.database;
    //   db.close();
    // }
  }
}
