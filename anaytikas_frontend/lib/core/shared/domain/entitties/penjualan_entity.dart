class PenjualanEntity {
  final int idPenjualan;
  final DateTime tanggal;
  final DateTime waktu;
  final int totalItem;
  final double totalHarga;

  PenjualanEntity({
    required this.idPenjualan,
    required this.tanggal,
    required this.waktu,
    required this.totalItem,
    required this.totalHarga,
  });
}
