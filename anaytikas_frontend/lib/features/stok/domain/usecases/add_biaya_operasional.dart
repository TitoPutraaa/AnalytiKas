import '../../../../core/shared/domain/entitties/biaya_operasional_entity.dart';
import '../repository/stok_repository.dart';

class AddBiayaOperasional {
  final StokRepository stokRepository;

  AddBiayaOperasional({required this.stokRepository});

  Future<void> call(
    int idBiaya,
    String nama,
    DateTime tanggal,
    DateTime waktu,
    double harga,
  ) {
    final BiayaOperasionalEntity data = BiayaOperasionalEntity(
      idBiaya: idBiaya,
      nama: nama,
      tanggal: tanggal,
      harga: harga,
      waktu: waktu,
    );
    return stokRepository.addBiayaOperasional(data);
  }
}
