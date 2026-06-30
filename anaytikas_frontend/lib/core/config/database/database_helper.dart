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
    const doubleType = 'REAL NOT NULL';

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
        satuan $textType
      )
    ''');

    // 5. Tabel product
    await db.execute('''
      CREATE TABLE product (
        id_product $idType,
        nama_product $textType,
        jmlh_stok $intType, 
        is_grosir $intType,
        is_active $intType,
        id_kategori $intType,
        id_harga $intType,
        stok_warning $intType,
        FOREIGN KEY (id_kategori) REFERENCES kategori (id_kategori) ON DELETE RESTRICT,
        FOREIGN KEY (id_harga) REFERENCES harga_product (id_harga) ON DELETE RESTRICT
      )
    ''');

    // 6. Tabel penjualan
    await db.execute('''
      CREATE TABLE penjualan (
        id_penjualan $idTypeInc,
        tanggal $textType,
        waktu $textType,
        total_item $intType,
        total_harga $doubleType,
        uang_masuk $doubleType
      )
    ''');
    // 7. Tabel pembelian
    await db.execute('''
      CREATE TABLE pembelian (
        id_pembelian $idTypeInc,
        tanggal $textType,
        waktu $textType,
        total_harga $doubleType
      )
    ''');

    // 8. Tabel product per penjualan
    await db.execute('''
      CREATE TABLE product_per_penjualan (
        id_penjualan $intType,
        id_product $intType,
        jumlah $intType,
        PRIMARY KEY (id_penjualan, id_product),
        FOREIGN KEY (id_penjualan) REFERENCES penjualan (id_penjualan) ON DELETE CASCADE,
        FOREIGN KEY (id_product) REFERENCES product (id_product) ON DELETE RESTRICT
      )
    ''');
    // 9. Tabel product per pembelian
    await db.execute('''
      CREATE TABLE product_per_pembelian (
        id_pembelian $intType,
        id_product $intType,
        jumlah $intType,
        PRIMARY KEY (id_pembelian, id_product),
        FOREIGN KEY (id_pembelian) REFERENCES pembelian (id_pembelian) ON DELETE CASCADE,
        FOREIGN KEY (id_product) REFERENCES product (id_product) ON DELETE RESTRICT
      )
    ''');
    // 10. Tabel biaya operasional
    await db.execute('''
      CREATE TABLE biaya_operasional (
        id_biaya $idTypeInc,
        nama $textType,
        total_biaya $doubleType,
        tanggal $textType,
        waktu $textType
      )
    ''');

    // // Toko
    // await db.insert('toko', {
    //   'nama_toko': 'Toko Sembako Maju Jaya',
    //   'email': 'toko.majujaya@gmail.com',
    //   'no_telp': '081234567890',
    //   'password': 'password123',
    //   'alamat': 'Jl. Contoh Alamat No. 123, Denpasar, Bali',
    // });

    // // Kategori
    // await db.insert('kategori', {'nama_kategori': 'Makanan'});
    // await db.insert('kategori', {'nama_kategori': 'Minuman'});

    // // Harga
    // // ID 1: Eceran, ID 2: Grosir
    // await db.insert('harga_product', {
    //   'harga_jual': 3000.0,
    //   'harga_beli': 2500.0,
    //   'satuan': 'Pcs',
    // });
    // await db.insert('harga_product', {
    //   'harga_jual': 33000.0,
    //   'harga_beli': 30000.0,
    //   'satuan': 'Dus',
    // });

    // // Indomie Eceran (id_product: 101)
    // await db.insert('product', {
    //   'id_product': "7989243",
    //   'nama_product': 'Indomie Goreng (Ecer)',
    //   'jmlh_stok': 100,
    //   'is_grosir': 0,
    //   'is_active': 1,
    //   'id_kategori': 1,
    //   'id_harga': 1,
    //   'stok_warning': 10,
    // });

    // // Indomie Grosir (id_product: 102)
    // await db.insert('product', {
    //   'id_product': "979876",
    //   'nama_product': 'Indomie Goreng (Dus)',
    //   'jmlh_stok': 50,
    //   'is_grosir': 1,
    //   'is_active': 1,
    //   'id_kategori': 1,
    //   'id_harga': 2,
    //   'stok_warning': 5,
    // });

    // // Coca Cola Eceran (id_product: 201)
    // await db.insert('product', {
    //   'id_product': "877060",
    //   'nama_product': 'Coca Cola (Ecer)',
    //   'jmlh_stok': 50,
    //   'is_grosir': 0,
    //   'is_active': 1,
    //   'id_kategori': 2,
    //   'id_harga': 1,
    //   'stok_warning': 5,
    // });

    // Future close() async {
    //   final db = await instance.database;
    //   db.close();
    // }

    await db.insert('toko', {
      'nama_toko': 'Toko Sembako Maju Jaya',
      'email': 'toko.majujaya@gmail.com',
      'no_telp': '081234567890',
      'password': 'password123',
      'alamat': 'Jl. Gatot Subroto No. 45, Denpasar, Bali',
    });

    // ── KATEGORI ──────────────────────────────
    await db.insert('kategori', {'nama_kategori': 'Makanan'}); // id: 1
    await db.insert('kategori', {'nama_kategori': 'Minuman'}); // id: 2
    await db.insert('kategori', {'nama_kategori': 'Snack'}); // id: 3
    await db.insert('kategori', {'nama_kategori': 'Kebutuhan RT'}); // id: 4

    // ── HARGA PRODUCT ─────────────────────────
    await db.insert('harga_product', {
      'harga_jual': 3000.0,
      'harga_beli': 2500.0,
      'satuan': 'Pcs',
    }); // id: 1
    await db.insert('harga_product', {
      'harga_jual': 33000.0,
      'harga_beli': 28000.0,
      'satuan': 'Dus',
    }); // id: 2
    await db.insert('harga_product', {
      'harga_jual': 5000.0,
      'harga_beli': 4000.0,
      'satuan': 'Pcs',
    }); // id: 3
    await db.insert('harga_product', {
      'harga_jual': 55000.0,
      'harga_beli': 48000.0,
      'satuan': 'Karton',
    }); // id: 4
    await db.insert('harga_product', {
      'harga_jual': 8000.0,
      'harga_beli': 6500.0,
      'satuan': 'Pcs',
    }); // id: 5
    await db.insert('harga_product', {
      'harga_jual': 15000.0,
      'harga_beli': 12000.0,
      'satuan': 'Pcs',
    }); // id: 6
    await db.insert('harga_product', {
      'harga_jual': 12000.0,
      'harga_beli': 10000.0,
      'satuan': 'Pcs',
    }); // id: 7
    await db.insert('harga_product', {
      'harga_jual': 7000.0,
      'harga_beli': 5500.0,
      'satuan': 'Pcs',
    }); // id: 8

    // ── PRODUCT ───────────────────────────────
    // Makanan
    await db.insert('product', {
      'id_product': '7989243',
      'nama_product': 'Indomie Goreng (Ecer)',
      'jmlh_stok': 100,
      'is_grosir': 0,
      'is_active': 1,
      'id_kategori': 1,
      'id_harga': 1,
      'stok_warning': 10,
    });
    await db.insert('product', {
      'id_product': '979876',
      'nama_product': 'Indomie Goreng (Dus)',
      'jmlh_stok': 50,
      'is_grosir': 1,
      'is_active': 1,
      'id_kategori': 1,
      'id_harga': 2,
      'stok_warning': 5,
    });
    await db.insert('product', {
      'id_product': '8761234',
      'nama_product': 'Beras Premium 5kg',
      'jmlh_stok': 40,
      'is_grosir': 0,
      'is_active': 1,
      'id_kategori': 1,
      'id_harga': 6,
      'stok_warning': 5,
    });

    // Minuman
    await db.insert('product', {
      'id_product': '877060',
      'nama_product': 'Coca Cola (Ecer)',
      'jmlh_stok': 50,
      'is_grosir': 0,
      'is_active': 1,
      'id_kategori': 2,
      'id_harga': 3,
      'stok_warning': 5,
    });
    await db.insert('product', {
      'id_product': '877061',
      'nama_product': 'Coca Cola (Karton)',
      'jmlh_stok': 20,
      'is_grosir': 1,
      'is_active': 1,
      'id_kategori': 2,
      'id_harga': 4,
      'stok_warning': 3,
    });
    await db.insert('product', {
      'id_product': '334512',
      'nama_product': 'Teh Botol Sosro',
      'jmlh_stok': 60,
      'is_grosir': 0,
      'is_active': 1,
      'id_kategori': 2,
      'id_harga': 5,
      'stok_warning': 10,
    });

    // Snack
    await db.insert('product', {
      'id_product': '556677',
      'nama_product': 'Chitato Original',
      'jmlh_stok': 80,
      'is_grosir': 0,
      'is_active': 1,
      'id_kategori': 3,
      'id_harga': 8,
      'stok_warning': 10,
    });

    // Kebutuhan RT
    await db.insert('product', {
      'id_product': '112233',
      'nama_product': 'Sabun Lifebuoy',
      'jmlh_stok': 30,
      'is_grosir': 0,
      'is_active': 1,
      'id_kategori': 4,
      'id_harga': 7,
      'stok_warning': 5,
    });

    // // ── PENJUALAN ─────────────────────────────
    // await db.insert('penjualan', {
    //   'tanggal': '2026-06-20',
    //   'waktu': '08:30',
    //   'total_item': 3,
    //   'total_harga': 9000.0,
    // }); // id: 1

    // await db.insert('penjualan', {
    //   'tanggal': '2026-06-20',
    //   'waktu': '11:15',
    //   'total_item': 2,
    //   'total_harga': 23000.0,
    // }); // id: 2

    // await db.insert('penjualan', {
    //   'tanggal': '2026-06-21',
    //   'waktu': '09:00',
    //   'total_item': 4,
    //   'total_harga': 29000.0,
    // }); // id: 3

    // await db.insert('penjualan', {
    //   'tanggal': '2026-06-22',
    //   'waktu': '14:45',
    //   'total_item': 1,
    //   'total_harga': 15000.0,
    // }); // id: 4

    // // ── PRODUCT PER PENJUALAN ─────────────────
    // // Penjualan 1: 3x Indomie Ecer
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 1,
    //   'id_product': '7989243',
    //   'jumlah': 3,
    // });

    // // Penjualan 2: 1x Coca Cola Ecer + 1x Teh Botol
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 2,
    //   'id_product': '877060',
    //   'jumlah': 1,
    // });
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 2,
    //   'id_product': '334512',
    //   'jumlah': 3,
    // });

    // // Penjualan 3: 2x Indomie Ecer + 1x Chitato + 1x Teh Botol
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 3,
    //   'id_product': '7989243',
    //   'jumlah': 2,
    // });
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 3,
    //   'id_product': '556677',
    //   'jumlah': 1,
    // });
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 3,
    //   'id_product': '334512',
    //   'jumlah': 1,
    // });

    // // Penjualan 4: 1x Beras Premium
    // await db.insert('product_per_penjualan', {
    //   'id_penjualan': 4,
    //   'id_product': '8761234',
    //   'jumlah': 1,
    // });

    // // ── PEMBELIAN ─────────────────────────────
    // await db.insert('pembelian', {
    //   'tanggal': '2026-06-18',
    //   'waktu': '10:00',
    //   'total_item': 2,
    //   'total_harga': 56000.0,
    // }); // id: 1

    // await db.insert('pembelian', {
    //   'tanggal': '2026-06-19',
    //   'waktu': '13:30',
    //   'total_item': 3,
    //   'total_harga': 76000.0,
    // }); // id: 2

    // // ── PRODUCT PER PEMBELIAN ─────────────────
    // // Pembelian 1: 2x Indomie Dus
    // await db.insert('product_per_pembelian', {
    //   'id_pembelian': 1,
    //   'id_product': '979876',
    //   'jumlah': 2,
    // });

    // // Pembelian 2: 1x Coca Cola Karton + 1x Beras + 1x Sabun
    // await db.insert('product_per_pembelian', {
    //   'id_pembelian': 2,
    //   'id_product': '877061',
    //   'jumlah': 1,
    // });
    // await db.insert('product_per_pembelian', {
    //   'id_pembelian': 2,
    //   'id_product': '8761234',
    //   'jumlah': 1,
    // });
    // await db.insert('product_per_pembelian', {
    //   'id_pembelian': 2,
    //   'id_product': '112233',
    //   'jumlah': 1,
    // });

    // // ── BIAYA OPERASIONAL ─────────────────────
    // await db.insert('biaya_operasional', {
    //   'nama': 'Bayar Listrik',
    //   'total_biaya': 150000.0,
    //   'tanggal': '2026-06-18',
    //   'waktu': '09:00',
    // });
    // await db.insert('biaya_operasional', {
    //   'nama': 'Beli Plastik Kresek',
    //   'total_biaya': 25000.0,
    //   'tanggal': '2026-06-19',
    //   'waktu': '08:30',
    // });
    // await db.insert('biaya_operasional', {
    //   'nama': 'Servis Etalase',
    //   'total_biaya': 75000.0,
    //   'tanggal': '2026-06-21',
    //   'waktu': '15:00',
    // });
    // await db.insert('biaya_operasional', {
    //   'nama': 'Bayar Internet',
    //   'total_biaya': 200000.0,
    //   'tanggal': '2026-06-22',
    //   'waktu': '10:00',
    // });
  }
}
