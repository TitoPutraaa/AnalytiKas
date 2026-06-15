class Pembelian {
  final int? idPembelian;
  final String tanggal;
  final String waktu;
  final int totalItem;
  final double totalHarga;

  Pembelian({
    this.idPembelian,
    required this.tanggal,
    required this.waktu,
    required this.totalItem,
    required this.totalHarga,
  });
}
