import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';

abstract class RiwayatRepository {
  Future<List<RiwayatEntryEntity>> getRiwayat();
}
