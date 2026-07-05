import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

abstract class LocalDataSource {
  Future<Map<String, dynamic>> getToko();
  Future<List<Map<String, dynamic>>> getKategori();
  Future<List<Map<String, dynamic>>> getHargaProduct();
  Future<List<Map<String, dynamic>>> getProduct();
  Future<List<Map<String, dynamic>>> getPenjualan();
  Future<List<Map<String, dynamic>>> getPembelian();
  Future<List<Map<String, dynamic>>> getProductPerPenjualan();
  Future<List<Map<String, dynamic>>> getProductPerPembelian();
  Future<List<Map<String, dynamic>>> getBiayaOperasional();

  Future<void> saveToko(Map<String, dynamic> dataToko);
  Future<void> updateToko(Map<String, dynamic> dataToko);
  Future<void> saveProducts(List<Map<String, dynamic>> dataProducts);
  Future<void> saveHargaProducts(List<Map<String, dynamic>> dataHargaProducts);
  Future<void> saveBiayaOp(List<Map<String, dynamic>> dataBiayaOp);
  Future<void> savePembelian(List<Map<String, dynamic>> dataPembelian);
  Future<void> savePenjualan(List<Map<String, dynamic>> dataPenjualan);
  Future<void> saveProductPerPemb(
    List<Map<String, dynamic>> dataProductPerPemb,
  );
  Future<void> saveProductPerPenj(
    List<Map<String, dynamic>> dataProductPerPenj,
  );
  Future<void> saveKategori(List<Map<String, dynamic>> dataKategori);
  Future<String> getEmail();

  Future<void> clearAllTables();
  Future<void> resetAutoIncrement(String tableName, int maxId);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseHelper dbHelper;

  LocalDataSourceImpl({required this.dbHelper});

  @override
  Future<Map<String, dynamic>> getToko() async {
    final db = await dbHelper.database;
    final result = await db.query('toko');
    return result.first;
  }

  @override
  Future<List<Map<String, dynamic>>> getHargaProduct() async {
    final db = await dbHelper.database;
    return await db.query('harga_product');
  }

  @override
  Future<List<Map<String, dynamic>>> getKategori() async {
    final db = await dbHelper.database;
    return await db.query('kategori');
  }

  @override
  Future<List<Map<String, dynamic>>> getProduct() async {
    final db = await dbHelper.database;
    return await db.query('product');
  }

  @override
  Future<List<Map<String, dynamic>>> getPenjualan() async {
    final db = await dbHelper.database;
    return await db.query('penjualan');
  }

  @override
  Future<List<Map<String, dynamic>>> getPembelian() async {
    final db = await dbHelper.database;
    return await db.query('pembelian');
  }

  @override
  Future<List<Map<String, dynamic>>> getBiayaOperasional() async {
    final db = await dbHelper.database;
    return await db.query('biaya_operasional');
  }

  @override
  Future<List<Map<String, dynamic>>> getProductPerPenjualan() async {
    final db = await dbHelper.database;
    return await db.query('product_per_penjualan');
  }

  @override
  Future<List<Map<String, dynamic>>> getProductPerPembelian() async {
    final db = await dbHelper.database;
    return await db.query('product_per_pembelian');
  }

  @override
  Future<void> saveToko(Map<String, dynamic> dataToko) async {
    final db = await dbHelper.database;
    await db.insert(
      'toko',
      dataToko,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateToko(Map<String, dynamic> dataToko) async {
    final db = await dbHelper.database;
    await db.insert('toko', dataToko);
  }

  // Save Data
  @override
  Future<void> saveBiayaOp(List<Map<String, dynamic>> dataBiayaOp) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataBiayaOp) {
        await txn.insert('biaya_operasional', {
          'id_biaya': item['id_biaya'],
          'nama': item['nama'],
          'tanggal': item['tanggal'],
          'total_biaya': item['total_biaya'],
          'waktu': item['waktu'],
        });
      }
    });
  }

  @override
  Future<void> saveHargaProducts(
    List<Map<String, dynamic>> dataHargaProducts,
  ) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataHargaProducts) {
        await txn.insert('harga_product', {
          'id_harga': item['id_harga'],
          'harga_beli': item['harga_beli'],
          'harga_jual': item['harga_jual'],
          'satuan': item['satuan'],
        });
      }
    });
  }

  @override
  Future<void> savePembelian(List<Map<String, dynamic>> dataPembelian) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataPembelian) {
        await txn.insert('pembelian', {
          'id_pembelian': item['id_pembelian'],
          'tanggal': item['tanggal'],
          'total_harga': item['total_harga'],
          'waktu': item['waktu'],
        });
      }
    });
  }

  @override
  Future<void> savePenjualan(List<Map<String, dynamic>> dataPenjualan) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataPenjualan) {
        await txn.insert('penjualan', {
          'id_penjualan': item['id_penjualan'],
          'tanggal': item['tanggal'],
          'total_harga': item['total_harga'],
          'total_item': item['total_item'],
          'waktu': item['waktu'],
        });
      }
    });
  }

  @override
  Future<void> saveProductPerPemb(
    List<Map<String, dynamic>> dataProductPerPemb,
  ) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataProductPerPemb) {
        await txn.insert('product_per_pembelian', {
          'id_pembelian': item['id_pembelian'],
          'id_product': item['id_product'],
          'jumlah': item['jumlah'],
        });
      }
    });
  }

  @override
  Future<void> saveProductPerPenj(
    List<Map<String, dynamic>> dataProductPerPenj,
  ) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataProductPerPenj) {
        await txn.insert('product_per_penjualan', {
          'id_penjualan': item['id_penjualan'],
          'id_product': item['id_product'],
          'jumlah': item['jumlah'],
        });
      }
    });
  }

  @override
  Future<void> saveProducts(List<Map<String, dynamic>> dataProducts) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataProducts) {
        await txn.insert('product', {
          'id_product': item['id_product'],
          'id_harga': item['id_harga'],
          'id_kategori': item['id_kategori'],
          'is_active': item['is_active'],
          'is_grosir': item['is_grosir'],
          'jmlh_stok': item['jmlh_stok'],
          'nama_product': item['nama_product'],
          'stok_warning': item['stok_warning'],
        });
      }
    });
  }

  @override
  Future<void> saveKategori(List<Map<String, dynamic>> dataKategori) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      for (var item in dataKategori) {
        await txn.insert('kategori', {
          'id_kategori': item['id_kategori'],
          'nama_kategori': item['nama_kategori'],
        });
      }
    });
  }

  @override
  Future<String> getEmail() async {
    final db = await dbHelper.database;

    final result = await db.query('toko', columns: ['email'], limit: 1);
    return result.first['email'] as String;
  }

  @override
  Future<void> clearAllTables() async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      await txn.delete('product_per_pembelian');
      await txn.delete('product_per_penjualan');
      await txn.delete('product');
      await txn.delete('harga_product');
      await txn.delete('pembelian');
      await txn.delete('penjualan');
      await txn.delete('biaya_operasional');
      await txn.delete('kategori');
      await txn.delete('toko');
    });
  }

  @override
  Future<void> resetAutoIncrement(String tableName, int maxId) async {
    final db = await dbHelper.database;

    final result = await db.query(
      'sqlite_sequence',
      where: 'name = ?',
      whereArgs: [tableName],
    );

    if (result.isEmpty) {
      await db.insert('sqlite_sequence', {'name': tableName, 'seq': maxId});
    } else {
      await db.update(
        'sqlite_sequence',
        {'seq': maxId},
        where: 'name = ?',
        whereArgs: [tableName],
      );
    }
  }
}
