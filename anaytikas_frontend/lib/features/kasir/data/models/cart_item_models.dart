class CartItemModels {
  final int idProduct;
  final String namaProduct;
  final bool isGrosir;
  final String satuan;
  final int jmlSatuan;

  final double hargaEceran;
  final double? hargaGrosir;

  bool isGrosirActive;
  int quantity;

  CartItemModels({
    required this.idProduct,
    required this.namaProduct,
    required this.isGrosir,
    required this.satuan,
    required this.jmlSatuan,
    required this.hargaEceran,
    this.hargaGrosir,
    this.isGrosirActive = false,
    this.quantity = 1,
  });

  double get hargaAktif {
    if (isGrosirActive && hargaGrosir != null) {
      return hargaGrosir!;
    }
    return hargaEceran;
  }

  double get subtotal => hargaAktif * quantity;

  void add() => quantity += jmlSatuan;
  void remove() {
    if (quantity > jmlSatuan) {
      quantity -= jmlSatuan;
    }
  }
}
