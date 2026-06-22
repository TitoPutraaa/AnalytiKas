class TransaksiItemEntity {
  final String namaProduct;
  final int jumlah;
  final String satuan;
  final double totalHargaProduct;

  TransaksiItemEntity({
    required this.namaProduct,
    required this.jumlah,
    required this.satuan,
    required this.totalHargaProduct,
  });
}
