import 'harga_model.dart';
import 'kategori_model.dart';
import 'pembelian_model.dart';
import 'product_model.dart';
import '../../domain/entitties/product_per_pembelian_entity.dart';

class ProductPerPembelianModel extends ProductPerPembelianEntity {
  ProductPerPembelianModel({
    required super.pembelian,
    required super.product,
    required super.hargaSatuan,
    required super.jumlah,
  });

  factory ProductPerPembelianModel.fromMap(Map<String, dynamic> map) {
    return ProductPerPembelianModel(
      pembelian: PembelianModel.fromMap({
        'id_pembelian': map['id_pembelian'],
        'tanggal': map['tanggal'],
        'waktu': map['waktu'],
        'total_harga': map['total_harga'],
      }),

      product: ProductModel.fromMap({
        'id_product': map['id_product'],
        'nama_product': map['nama_product'],
        'jmlh_stok': map['jmlh_stok'],
        'is_grosir': map['is_grosir'],
        'is_active': map['is_active'],

        'pengingat_stok': map['pengingat_stok'],
        'kategori': KategoriModel.fromMap({
          'id_kategori': map['id_kategori'],
          'nama_kategori': map['nama_kategori'],
          'is_active': map['is_active'],
        }),
        'harga': HargaModel.fromMap({
          'id_harga': map['id_harga'],
          'harga_jual': map['harga_jual'],
          'harga_beli': map['harga_beli'],
          'satuan': map['satuan'],
        }),
      }),

      hargaSatuan: (map['harga_satuan'] as num).toDouble(),
      jumlah: map['jumlah'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_pembelian': pembelian.idPembelian,
      'id_product': product.idProduct,
      'harga_satuan': hargaSatuan,
      'jumlah': jumlah,
    };
  }
}
