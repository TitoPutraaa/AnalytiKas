class HargaProduct {
  final int idHarga;
  final double hargaJual;
  final double hargaBeli;
  final String satuan;

  HargaProduct({
    required this.idHarga,
    required this.hargaJual,
    required this.hargaBeli,
    required this.satuan,
  });

  HargaProduct copyWith({
    int? idHarga,
    double? hargaJual,
    double? hargaBeli,
    String? satuan,
  }) {
    return HargaProduct(
      idHarga: idHarga ?? this.idHarga,
      hargaJual: hargaJual ?? this.hargaJual,
      hargaBeli: hargaBeli ?? this.hargaBeli,
      satuan: satuan ?? this.satuan,
    );
  }
}
