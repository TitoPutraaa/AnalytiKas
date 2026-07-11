import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/features/stok/data/models/biaya_operasional_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/kategori_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_per_pembelian_model.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:sqflite/sqflite.dart';

abstract class StokLocalDatasource {
  Future<List<ProductModel>> getAllProductsData();
  Future<List<Kategori>> getAllCategory();
  Future<void> addBarangBaruData(ProductPerPembelianModel addBarang);
  Future<void> addBiayaOperasionalData(BiayaOperasionalModel addBiayaOps);
  Future<void> addStokData(ProductPerPembelianModel addStok);
  Future<void> updateProductData(ProductModel updProduct);
  Future<void> deleteProduct(ProductEntity delProduct);
}

class StokLocalDatasourceImpl implements StokLocalDatasource {
  final DatabaseHelper dbHelper;

  StokLocalDatasourceImpl({required this.dbHelper});

  @override
  Future<List<ProductModel>> getAllProductsData() async {
    final db = await dbHelper.database;
    List<Map<String, dynamic>> maps = await db.rawQuery(queryGetAll, [1]);

    return maps.map((row) => ProductModel.fromJoinedMap(row)).toList();
  }

  @override
  Future<void> addBarangBaruData(ProductPerPembelianModel addBarang) async {
    final db = await dbHelper.database;
    final now = DateTime.now();

    await db.transaction((txn) async {
      final idHarga = await txn.insert("harga_product", {
        "harga_jual": addBarang.product.harga.hargaJual,
        "harga_beli": addBarang.product.harga.hargaBeli,
        "satuan": addBarang.product.harga.satuan,
      }, conflictAlgorithm: ConflictAlgorithm.fail);

      final idPembelian = await txn.insert("pembelian", {
        "tanggal": now.toIso8601String().split("T")[0],
        "waktu": now.toIso8601String().split("T")[1].substring(0, 8),
        "total_harga": addBarang.product.harga.hargaBeli * addBarang.jumlah,
      });

      final productMap = ProductModel(
        idProduct: addBarang.product.idProduct,
        kategori: addBarang.product.kategori,
        harga: addBarang.product.harga,
        namaProduct: addBarang.product.namaProduct,
        jmlhStok: addBarang.product.jmlhStok,
        stokWarning: addBarang.product.stokWarning,
        isActivate: addBarang.product.isActivate,
        isGrosir: addBarang.product.isGrosir,
      ).toMap();

      productMap["id_harga"] = idHarga;

      await txn.insert(
        "product",
        productMap,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
      await txn.insert("product_per_pembelian", {
        "id_pembelian": idPembelian,
        "id_product": addBarang.product.idProduct,
        "jumlah": addBarang.jumlah,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
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
  Future<void> addStokData(ProductPerPembelianModel addStok) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      // 1. Create pembelian record
      final now = DateTime.now();
      final idPembelian = await txn.insert("pembelian", {
        "tanggal": now.toIso8601String().split("T")[0],
        "waktu": now.toIso8601String().split("T")[1].substring(0, 8),
        "total_harga": addStok.product.harga.hargaBeli * addStok.jumlah,
      });

      // 2. Insert product_per_pembelian
      await txn.insert("product_per_pembelian", {
        "id_pembelian": idPembelian,
        "id_product": addStok.product.idProduct,
        "jumlah": addStok.jumlah,
      }, conflictAlgorithm: ConflictAlgorithm.replace);

      // 3. Update jmlh_stok on the product
      await txn.rawUpdate(
        "UPDATE product SET jmlh_stok = jmlh_stok + ? WHERE id_product = ?",
        [addStok.jumlah, addStok.product.idProduct],
      );
    });
  }

  @override
  Future<void> updateProductData(ProductModel updProduct) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      // Update the product record (without id_harga, id_kategori FK fields conflicting)
      final productMap = updProduct.toMap();
      await txn.update(
        "product",
        productMap,
        where: "id_product = ?",
        whereArgs: [updProduct.idProduct],
      );

      await txn.update(
        "harga_product",
        {
          "harga_jual": updProduct.harga.hargaJual,
          "harga_beli": updProduct.harga.hargaBeli,
          "satuan": updProduct.harga.satuan,
        },
        where: "id_harga = ?",
        whereArgs: [updProduct.harga.idHarga],
      );
    });
  }

  @override
  Future<List<Kategori>> getAllCategory() async {
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

  final String queryGetAll = '''
  SELECT
    product.id_product,
    product.nama_product,
    product.jmlh_stok,
    product.stok_warning,
    product.is_active,
    product.is_grosir,
    kategori.id_kategori,
    kategori.nama_kategori,
    harga_product.id_harga,
    harga_product.harga_jual,
    harga_product.harga_beli,
    harga_product.satuan
  FROM product
  LEFT JOIN kategori      ON product.id_kategori = kategori.id_kategori
  LEFT JOIN harga_product ON product.id_harga    = harga_product.id_harga
  WHERE product.is_active = ?
  ''';
}
