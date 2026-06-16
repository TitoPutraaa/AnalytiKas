import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class AddBiayaOperasional {
  final StokRepository stokRepository;

  AddBiayaOperasional({required this.stokRepository});

  Future<void> call(
    int idBiaya,
    String nama,
    DateTime tanggal,
    double totalBiaya,
  ) {
    return stokRepository.addBiayaOperasional(
      idBiaya,
      nama,
      tanggal,
      totalBiaya,
    );
  }
}
