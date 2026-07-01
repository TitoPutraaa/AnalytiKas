class AnalisisEntitiy {
  final double brutto;
  final double netto;
  final double margin;
  final double presentase;
  final int tahun;
  final String bulan;
  final double totalBiayaOperasional;
  final int totalPembelian;
  final int totalPenjualan;

  AnalisisEntitiy({
    required this.brutto,
    required this.netto,
    required this.margin,
    required this.presentase,
    required this.tahun,
    required this.totalBiayaOperasional,
    required this.totalPembelian,
    required this.totalPenjualan,
    required this.bulan,
  });
}
