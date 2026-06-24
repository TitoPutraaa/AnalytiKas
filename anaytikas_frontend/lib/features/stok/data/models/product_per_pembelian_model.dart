import 'package:anaytikas_frontend/features/stok/data/models/harga_product_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/kategori_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/pembelian_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/product_model.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_per_pembelian.dart';

class ProductPerPembelianModel extends ProductPerPembelian {
  ProductPerPembelianModel({
    required super.pembelian,
    required super.product,
    required super.jumlah,
  });

  factory ProductPerPembelianModel.fromJoinedMap(Map<String, dynamic> data) {
    Pembelian pembelian;
    pembelian = PembelianModel(
      idPembelian: data["id_pembelian"] as int,
      tanggal: DateTime.parse(data["tanggal"] as String),
      waktu: data["waktu"] as String,
      totalItem: data["total_item"] as int,
      totalHarga: (data["total_harga"] as num).toDouble(),
    );

    Kategori kategori;
    kategori = KategoriModel(
      idKategori: data["id_kategori"] as int,
      namaKategori: data["nama_kategori"] as String,
    );

    HargaProduct hargaProduct;
    hargaProduct = HargaProductModel(
      idHarga: data["id_harga"] as int,
      hargaJual: (data["harga_jual"] as num).toDouble(),
      hargaBeli: (data["harga_beli"] as num).toDouble(),
      satuan: data["satuan"] as String,
    );

    ProductEntity product;
    product = ProductModel(
      idProduct: data["id_product"] as int,
      kategori: kategori,
      harga: hargaProduct,
      namaProduct: data["nama_product"] as String,
      jmlhStok: data["jmlh_stok"] as int,
      stokWarning: data["stok_warning"] as int,
      isActivate: (data["is_active"] as int) == 1,
      isGrosir: (data["is_grosir"] as int) == 1,
    );

    return ProductPerPembelianModel(
      pembelian: pembelian,
      product: product,
      jumlah: data["jumlah"] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id_pembelian": pembelian.idPembelian,
      "id_product": product.idProduct,
      "jumlah": jumlah,
    };
  }
}
