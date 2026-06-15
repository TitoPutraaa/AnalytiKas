class Pembelian {
  final int idPembelian;
  final DateTime tanggal;
  final String waktu;
  final int totalItem;
  final double totalHarga;

  Pembelian({
    required this.idPembelian,
    required this.tanggal,
    required this.waktu,
    required this.totalItem,
    required this.totalHarga,
  });
}
