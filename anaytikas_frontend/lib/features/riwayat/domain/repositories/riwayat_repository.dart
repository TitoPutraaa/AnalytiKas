abstract class RiwayatRepository {
  Future<List<Map<String, dynamic>>> getRiwayatGabunganByTanggal(
    String tanggal,
  );
  Future<Map<String, dynamic>?> getDetailPenjualan(int idPenjualan);
  Future<Map<String, dynamic>?> getDetailPembelian(int idPembelian);
}
