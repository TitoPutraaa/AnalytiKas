import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';

class BiayaOperasionalException implements Exception {
  final String message;
  const BiayaOperasionalException(this.message);

  @override
  String toString() => message;
}

class AddBiayaOperasional {
  final StokRepository stokRepository;

  AddBiayaOperasional({required this.stokRepository});

  Future<void> call(
    int idBiaya,
    String nama,
    DateTime tanggal,
    DateTime waktu,
    double totalBiaya,
  ) {
    if (totalBiaya == 0) {
      throw BiayaOperasionalException(
        "Nominal biaya operasional tidak boleh 0",
      );
    }
    if (totalBiaya < 0) {
      throw BiayaOperasionalException(
        "Nominal biaya operasional tidak boleh kurang dari 0",
      );
    }
    return stokRepository.addBiayaOperasional(
      idBiaya,
      nama,
      tanggal,
      waktu,
      totalBiaya,
    );
  }
}
