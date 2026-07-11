class PenjualanEntity {
  final int idPenjualan;
  final String tanggal;
  final String waktu;
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
