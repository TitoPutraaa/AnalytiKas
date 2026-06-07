class CartItemModels {
  final int idProduct;
  final String namaProduct;
  final int jmlhStok;
  final bool isGrosir;
  final int jmlSatuanEceran;
  final int? jmlSatuanGrosir;

  final double hargaEceran;
  final double? hargaGrosir;

  bool isGrosirActive;
  int quantity;
  String message;

  CartItemModels({
    required this.idProduct,
    required this.namaProduct,
    required this.jmlhStok,
    required this.isGrosir,
    required this.jmlSatuanEceran,
    required this.hargaEceran,
    this.jmlSatuanGrosir,
    this.hargaGrosir,
    this.isGrosirActive = false,
    this.quantity = 0,
    this.message = '',
  });

  double get hargaAktif {
    if (isGrosirActive && hargaGrosir != null) {
      return hargaGrosir!;
    }
    return hargaEceran;
  }

  double get subtotal => hargaAktif * quantity;

  void add() {
    if (!isGrosir) {
      quantity += jmlSatuanEceran;
    } else if (isGrosir && !isGrosirActive) {
      if (quantity < jmlhStok) {
        quantity += jmlSatuanEceran;
      } else {
        message = 'Stok kurang!';
      }
    } else if (isGrosir && isGrosirActive) {
      if (quantity <= (jmlhStok - jmlSatuanGrosir!)) {
        quantity += jmlSatuanGrosir!;
      } else {
        message = 'Stok kurang!';
      }
    }
  }

  void remove() {
    if (!isGrosir) {
      if (quantity > 0) {
        quantity -= jmlSatuanEceran;
      }
    } else if (isGrosir && !isGrosirActive) {
      if (quantity > 0) {
        quantity -= jmlSatuanEceran;
      }
    } else if (isGrosir && isGrosirActive) {
      if (quantity > jmlSatuanGrosir!) {
        quantity -= jmlSatuanGrosir!;
      }
    }
  }
}
