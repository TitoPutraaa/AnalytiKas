sealed class RiwayatEntryEntity {
  final String tanggal;
  final String waktu;
  const RiwayatEntryEntity({required this.tanggal, required this.waktu});
}

class RiwayatPenjualan extends RiwayatEntryEntity {
  final int idPenjualan;
  final int totalItem;
  final double totalHarga;
  final List<ItemDetail> items;
  final String namaToko;
  final String alamat;

  const RiwayatPenjualan({
    required this.idPenjualan,
    required super.tanggal,
    required super.waktu,
    required this.totalItem,
    required this.totalHarga,
    required this.items,
    required this.namaToko,
    required this.alamat,
  });
}

class RiwayatPembelian extends RiwayatEntryEntity {
  final int idPembelian;
  final double totalHarga;
  final String namaProduct;
  final int jumlah;
  final String satuan;

  const RiwayatPembelian({
    required this.idPembelian,
    required super.tanggal,
    required super.waktu,
    required this.totalHarga,
    required this.namaProduct,
    required this.jumlah,
    required this.satuan,
  });
}

class RiwayatOperasional extends RiwayatEntryEntity {
  final int idBiaya;
  final String namaBiaya;
  final double totalBiaya;

  const RiwayatOperasional({
    required this.idBiaya,
    required super.tanggal,
    required super.waktu,
    required this.namaBiaya,
    required this.totalBiaya,
  });
}

class ItemDetail {
  final String namaProduct;
  final int jumlah;
  final String satuan;
  final double totalHargaPerProduct;
  ItemDetail({
    required this.namaProduct,
    required this.jumlah,
    required this.satuan,
    required this.totalHargaPerProduct,
  });
}
