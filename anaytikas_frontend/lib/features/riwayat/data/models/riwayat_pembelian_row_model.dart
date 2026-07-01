// ============================================
// data/models/pembelian_row_model.dart
// ============================================
class RiwayatPembelianRowModel {
  final int idPembelian;
  final String tanggal;
  final String waktu;
  final double totalHarga;
  final String namaProduct;
  final int jumlah;
  final String satuan;

  RiwayatPembelianRowModel({
    required this.idPembelian,
    required this.tanggal,
    required this.waktu,
    required this.totalHarga,
    required this.namaProduct,
    required this.jumlah,
    required this.satuan,
  });

  factory RiwayatPembelianRowModel.fromMap(Map<String, dynamic> map) {
    return RiwayatPembelianRowModel(
      idPembelian: map['id_pembelian'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      totalHarga: (map['total_harga'] as num).toDouble(),
      namaProduct: map['nama_product'] as String,
      jumlah: map['jumlah'] as int,
      satuan: map['satuan'] as String,
    );
  }
}
