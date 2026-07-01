// ============================================
// data/models/penjualan_row_model.dart
// ============================================
class RiwayatPenjualanRowModel {
  final int idPenjualan;
  final String tanggal;
  final String waktu;
  final int totalItem;
  final double totalHarga;
  final String namaProduct;
  final int jumlah;
  final String satuan;
  final double totalHargaPerProduct;
  final String namaToko;
  final String alamat;

  RiwayatPenjualanRowModel({
    required this.idPenjualan,
    required this.tanggal,
    required this.waktu,
    required this.totalItem,
    required this.totalHarga,
    required this.namaProduct,
    required this.jumlah,
    required this.satuan,
    required this.totalHargaPerProduct,
    required this.namaToko,
    required this.alamat,
  });

  factory RiwayatPenjualanRowModel.fromMap(Map<String, dynamic> map) {
    return RiwayatPenjualanRowModel(
      idPenjualan: map['id_penjualan'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalItem: map['total_item'] as int,
      totalHarga: (map['total_harga'] as num).toDouble(),
      namaProduct: map['nama_product'] as String,
      jumlah: map['jumlah'] as int,
      satuan: map['satuan'] as String,
      totalHargaPerProduct: (map['total_harga_per_product'] as num).toDouble(),
      namaToko: map['nama_toko'] as String,
      alamat: map['alamat'] as String,
    );
  }
}
