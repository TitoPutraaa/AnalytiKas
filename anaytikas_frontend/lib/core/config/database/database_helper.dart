import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('analytikas');
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
    const textType = 'TEXT NOT NULL';
    const intType = 'INTEGER NOT NULL';
    const textNullable = 'TEXT';
    const doubleType = 'DOUBLE NOT NULL';

    // 1. Tabel Session User
    await db.execute('''
      CREATE TABLE session-user(
        id_toko $idType,
        session $textNullable
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

    // 3. Tabel product
    await db.execute('''
      CREATE TABLE product (
        id_product $idType,
        nama_product $textType,
        jmlh_stok $intType,
        is_grosir $intType,
        is_active $intType,
        id_kategori $intType,
        id_harga $intType,
        FOREIGN KEY (id_kategori) REFERENCES kategori (id_product) ON DELETE RESTRICT,
        FOREIGN KEY (id_harga) REFERENCES harga_product (id_product) ON DELETE RESTRICT,
    ''');

    // 4. Tabel penjualan
    await db.execute('''
      CREATE TABLE penjualan (
        id_penjualan $idType,
        tanggal $textType,
        waktu $textType,
        total_item $intType,
        total_harga $doubleType,
        uang_masuk $doubleType
      )
    ''');
    // 5. Tabel penjualan
    await db.execute('''
      CREATE TABLE pembelian (
        id_pembelian $idType,
        tanggal $textType,
        waktu $textType,
        total_item $intType,
        total_harga $doubleType
      )
    ''');
    // 6. Tabel Kategori
    await db.execute('''
      CREATE TABLE kategori(
        id_kategori $idType,
        nama_kategori $textType 
      )
    ''');
    // 7. Tabel harga product
    await db.execute('''
      CREATE TABLE harga_product (
        id_harga $idType,
        harga_jual $doubleType,
        harga_beli $doubleType,
        satuan $textType,
        jmlh_satuan $intType
      )
    ''');
    // 8. Tabel product per penjualan
    await db.execute('''
      CREATE TABLE product_per_penjualan (
        id_penjualan $idType,
        id_product $idType,
        jumlah $intType,
        FOREIGN KEY (id_penjualan) REFERENCES pembelian (id_penjualan) ON DELETE RESTRICT,
        FOREIGN KEY (id_product) REFERENCES product (id_product) ON DELETE RESTRICT,
      )
    ''');
    // 9. Tabel product per pembelian
    await db.execute('''
      CREATE TABLE product_per_pembelian (
        id_pembelian $idType,
        id_product $idType,
        jumlah $intType,
        FOREIGN KEY (id_pembelian) REFERENCES pembelian (id_pembelian) ON DELETE RESTRICT,
        FOREIGN KEY (id_product) REFERENCES product (id_product) ON DELETE RESTRICT,
      )
    ''');

    // Future close() async {
    //   final db = await instance.database;
    //   db.close();
    // }
  }
}
