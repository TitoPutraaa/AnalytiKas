class BiayaOprEntity {
  final int idBiaya;
  final String nama;
  final DateTime tanggal;
  final DateTime waktu;
  final double totalBiaya;

  BiayaOprEntity({
    required this.idBiaya,
    required this.nama,
    required this.tanggal,
    required this.totalBiaya,
    required this.waktu,
  });
}
