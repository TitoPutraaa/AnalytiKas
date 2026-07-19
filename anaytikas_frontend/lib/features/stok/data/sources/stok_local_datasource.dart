import '../../../../core/shared/data/models/biaya_operasional_model.dart';
import '../../../../core/shared/data/models/harga_model.dart';
import '../../../../core/shared/data/models/kategori_model.dart';
import '../../../../core/shared/data/models/pembelian_model.dart';
import '../../../../core/shared/data/models/product_model.dart';
import '../../../../core/shared/data/models/product_per_pembelian_model.dart';
import '../../../../core/shared/domain/entitties/product_entity.dart';

import '../../../../core/config/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

abstract class StokLocalDatasource {
  Future<List<ProductModel>> getAllProductsData();
  Future<List<KategoriModel>> getAllCategory();
  Future<void> addBarangBaru(ProductPerPembelianModel data);
  Future<void> addBiayaOperasionalData(BiayaOperasionalModel addBiayaOps);
  Future<void> addStokData(ProductPerPembelianModel data);
  Future<void> updateProductData(ProductModel updProduct);
  Future<void> deleteProduct(ProductEntity delProduct);
}

class StokLocalDatasourceImpl implements StokLocalDatasource {
  final DatabaseHelper dbHelper;

  StokLocalDatasourceImpl({required this.dbHelper});

  @override
  Future<List<ProductModel>> getAllProductsData() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.rawQuery('''
        SELECT 
          p.id_product, p.nama_product, p.jmlh_stok, p.is_grosir, p.is_active AS is_active_product, p.pengingat_stok, 
          k.id_kategori, k.nama_kategori, k.is_active AS is_active_kategori,
          h.id_harga, h.harga_jual, h.harga_beli, h.satuan 

        FROM product p
        INNER JOIN kategori k ON p.id_kategori = k.id_kategori
        INNER JOIN harga_product h ON p.id_harga = h.id_harga
        
        WHERE p.is_active = 1;
    ''');

    return maps.map((row) => ProductModel.fromMap(row)).toList();
  }

  @override
  Future<void> addBarangBaru(ProductPerPembelianModel data) async {
    final db = await dbHelper.database;

    final hargaMap = HargaModel.fromEntity(
      data.product.harga,
    ).toMap(includeId: false);
    final pembelianMap = PembelianModel.fromEntity(
      data.pembelian,
    ).toMap(includeId: false);
    final productMap = ProductModel.fromEntity(data.product).toMap();
    final pppembelianMap = data.toMap();

    await db.transaction((txn) async {
      final idHarga = await txn.insert(
        "harga_product",
        hargaMap,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      final idPembelian = await txn.insert("pembelian", pembelianMap);

      productMap['id_harga'] = idHarga;
      await txn.insert(
        "product",
        productMap,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );

      pppembelianMap['id_pembelian'] = idPembelian;
      await txn.insert(
        "product_per_pembelian",
        pppembelianMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  @override
  Future<void> addBiayaOperasionalData(
    BiayaOperasionalModel addBiayaOps,
  ) async {
    final db = await dbHelper.database;
    await db.insert(
      "biaya_operasional",
      addBiayaOps.toMap(includeId: false),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  @override
  Future<void> addStokData(ProductPerPembelianModel data) async {
    final db = await dbHelper.database;

    final pembelianMap = PembelianModel.fromEntity(
      data.pembelian,
    ).toMap(includeId: false);

    final Map<String, dynamic> pppembelianMap = data.toMap();

    await db.transaction((txn) async {
      // 1. Create pembelian record
      final idPembelian = await txn.insert("pembelian", pembelianMap);

      // 2. Insert product_per_pembelian
      pppembelianMap['id_pembelian'] = idPembelian;
      await txn.insert(
        "product_per_pembelian",
        pppembelianMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // 3. Update jmlh_stok on the product
      await txn.rawUpdate(
        "UPDATE product SET jmlh_stok = jmlh_stok + ? WHERE id_product = ?",
        [pppembelianMap['jumlah'], pppembelianMap['id_product']],
      );
    });
  }

  @override
  Future<void> updateProductData(ProductModel updProduct) async {
    final db = await dbHelper.database;
    final hargaMap = HargaModel.fromEntity(
      updProduct.harga,
    ).toMap(includeId: false);
    final productMap = updProduct.toMap();

    await db.transaction((txn) async {
      // Update the product record (without id_harga, id_kategori FK fields conflicting)
      await txn.update(
        "product",
        productMap,
        where: "id_product = ?",
        whereArgs: [updProduct.idProduct],
      );

      await txn.update(
        "harga_product",
        hargaMap,
        where: "id_harga = ?",
        whereArgs: [updProduct.harga.idHarga],
      );
    });
  }

  @override
  Future<List<KategoriModel>> getAllCategory() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> data = await db.query("kategori");

    return data.map((map) => KategoriModel.fromMap(map)).toList();
  }

  @override
  Future<void> deleteProduct(ProductEntity delProduct) async {
    final db = await dbHelper.database;
    await db.update(
      "product",
      {"is_active": 0},
      where: "id_product = ?",
      whereArgs: [delProduct.idProduct],
    );
  }
}
