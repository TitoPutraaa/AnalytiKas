class Product {
  final String idProduct;
  final int idKategori;
  final String namaProduct;
  final int jmlhStok;
  final int minStok;
  final bool isGrosir;
  final bool isActive;
  final double harga;

  Product({
    required this.idProduct,
    required this.idKategori,
    required this.namaProduct,
    required this.jmlhStok,
    required this.minStok,
    required this.isGrosir,
    required this.isActive,
    required this.harga,
  });

  static Product get dummy => Product(
    idProduct: '12fds13',
    idKategori: 3,
    namaProduct: "Kopi Arabica 250g",
    jmlhStok: 12,
    minStok: 10,
    harga: 10000,
    isGrosir: false,
    isActive: true,
  );
}
