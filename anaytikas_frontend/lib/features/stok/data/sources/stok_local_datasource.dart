import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/features/stok/data/models/biaya_operasional_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/kategori_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_per_pembelian_model.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_category.dart';
import 'package:sqflite/sqflite.dart';

abstract class StokLocalDatasource {
  Future<List<ProductModel>> getAllProductsData();
  Future<List<Kategori>> getAllCategory();
  Future<void> addBarangBaruData(ProductModel addBarang);
  Future<void> addBiayaOperasionalData(BiayaOperasionalModel addBiayaOps);
  Future<void> addStokData(ProductPerPembelianModel addStok);
  Future<void> updateProductData(ProductModel updProduct);
}

class StokLocalDatasourceImpl implements StokLocalDatasource {
  final DatabaseHelper dbHelper;

  StokLocalDatasourceImpl({required this.dbHelper});

  @override
  Future<List<ProductModel>> getAllProductsData() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.rawQuery(queryGetAll);

    return maps.map((row) => ProductModel.fromJoinedMap(row)).toList();
  }

  @override
  Future<void> addBarangBaruData(ProductModel addBarang) async {
    final db = await dbHelper.database;
    await db.insert(
      "product",
      addBarang.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> addBiayaOperasionalData(
    BiayaOperasionalModel addBiayaOps,
  ) async {
    final db = await dbHelper.database;
    await db.insert(
      "biaya_operasional",
      addBiayaOps.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> addStokData(ProductPerPembelianModel addStok) async {
    final db = await dbHelper.database;
    await db.insert(
      "biaya_operasional",
      addStok.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> updateProductData(ProductModel updProduct) async {
    final db = await dbHelper.database;
    await db.update(
      "product",
      updProduct.toMap(),
      where: "id_product = ?",
      whereArgs: [updProduct.idProduct],
    );
  }

  @override
  Future<List<Kategori>> getAllCategory() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> data = await db.query("kategori");

    return data.map((map) => KategoriModel.fromMap(map)).toList();
  }

  final String queryGetAll = '''
  SELECT
    product.id_product,
    product.nama_product,
    product.jmlh_stok,
    product.warning_stok,
    kategori.id_kategori,
    kategori.nama_kategori,
    harga_product.id_harga,
    harga_product.harga_jual
  FROM product
  LEFT JOIN kategori      ON product.id_kategori = kategori.id_kategori
  LEFT JOIN harga_product ON product.id_harga    = harga_product.id_harga
  ''';
}
