// ============================================
// data/models/biaya_model.dart
// ============================================
// Catatan: tabel Biaya tidak ada JOIN, 1 row SQL = 1 entity nantinya.
// Tetap dipisah filenya demi konsistensi struktur, walau strukturnya simpel.
class RiwayatOperasionalModel {
  final int idBiaya;
  final String tanggal;
  final String waktu;
  final String namaBiaya;
  final double totalBiaya;

  RiwayatOperasionalModel({
    required this.idBiaya,
    required this.tanggal,
    required this.waktu,
    required this.namaBiaya,
    required this.totalBiaya,
  });

  factory RiwayatOperasionalModel.fromMap(Map<String, dynamic> map) {
    return RiwayatOperasionalModel(
      idBiaya: map['id_biaya'] as int,
      tanggal: map['tanggal'] as String,
      waktu: map['waktu'] as String,
      namaBiaya: map['nama'] as String,
      totalBiaya: (map['total_biaya'] as num).toDouble(),
    );
  }
}
