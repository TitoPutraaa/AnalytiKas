import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/repositories/riwayat_repository.dart';

class GetRiwayatUsecase {
  final RiwayatRepository repository;
  GetRiwayatUsecase(this.repository);
  Future<List<RiwayatEntryEntity>> call() => repository.getRiwayat();
}
