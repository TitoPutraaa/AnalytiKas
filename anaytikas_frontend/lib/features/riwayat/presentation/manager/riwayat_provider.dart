import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/usecases/get_riwayat_usecase.dart';
import 'package:flutter/foundation.dart';

class RiwayatProvider extends ChangeNotifier {
  final GetRiwayatUsecase getRiwayat;
  RiwayatProvider({required this.getRiwayat});

  List<RiwayatEntryEntity> _riwayat = [];
  bool isLoading = false;

  // Sudah dikelompokkan per tanggal, siap dipakai UI
  Map<String, List<RiwayatEntryEntity>> get groupedByTanggal {
    final map = <String, List<RiwayatEntryEntity>>{};
    for (final entry in _riwayat) {
      map.putIfAbsent(entry.tanggal, () => []).add(entry);
    }
    return map;
  }

  Future<void> loadRiwayat() async {
    isLoading = true;

    try {
      _riwayat = await getRiwayat();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
