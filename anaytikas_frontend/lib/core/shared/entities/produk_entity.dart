class ProdukEntity {
  final int idProduct;
  final String namaProduct;
  final int jmlhStok;
  final bool isGrosir;
  final bool isActivate;
  final int idKategori;
  final int idHarga;
  final int warningStok;

  ProdukEntity({
    required this.idProduct,
    required this.namaProduct,
    required this.jmlhStok,
    required this.isGrosir,
    required this.isActivate,
    required this.idKategori,
    required this.idHarga,
    required this.warningStok,
  });
}
