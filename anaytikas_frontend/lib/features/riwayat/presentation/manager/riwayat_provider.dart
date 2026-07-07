// import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
// import 'package:anaytikas_frontend/features/riwayat/domain/usecases/get_riwayat_usecase.dart';
// import 'package:flutter/foundation.dart';

// class RiwayatProvider extends ChangeNotifier {
//   final GetRiwayatUsecase getRiwayat;
//   RiwayatProvider({required this.getRiwayat});

//   List<RiwayatEntryEntity> _riwayat = [];
//   bool isLoading = false;

//   // Sudah dikelompokkan per tanggal, siap dipakai UI
//   Map<String, List<RiwayatEntryEntity>> get groupedByTanggal {
//     final map = <String, List<RiwayatEntryEntity>>{};
//     for (final entry in _riwayat) {
//       map.putIfAbsent(entry.tanggal, () => []).add(entry);
//     }
//     return map;
//   }

//   Future<void> loadRiwayat() async {
//     isLoading = true;

//     try {
//       _riwayat = await getRiwayat();
//     } catch (e) {
//       print(e);
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/usecases/get_riwayat_usecase.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/date_filter_dialog.dart';
import 'package:flutter/foundation.dart';

class RiwayatProvider extends ChangeNotifier {
  final GetRiwayatUsecase getRiwayat;
  RiwayatProvider({required this.getRiwayat});

  List<RiwayatEntryEntity> _riwayat = [];
  bool isLoading = false;

  DateTime? startDate;
  DateTime? endDate;

  List<RiwayatEntryEntity> get _filteredRiwayat {
    if (startDate == null || endDate == null) return _riwayat;

    final start = DateTime(startDate!.year, startDate!.month, startDate!.day);
    final end = DateTime(
      endDate!.year,
      endDate!.month,
      endDate!.day,
      23,
      59,
      59,
    );

    return _riwayat.where((entry) {
      final tgl = DateTime.parse(
        entry.tanggal,
      ); // sesuaikan format, lihat catatan di bawah
      return !tgl.isBefore(start) && !tgl.isAfter(end);
    }).toList();
  }

  Map<String, List<RiwayatEntryEntity>> get groupedByTanggal {
    final map = <String, List<RiwayatEntryEntity>>{};
    for (final entry in _filteredRiwayat) {
      map.putIfAbsent(entry.tanggal, () => []).add(entry);
    }
    return map;
  }

  Future<void> loadRiwayat() async {
    isLoading = true;
    notifyListeners();
    try {
      _riwayat = await getRiwayat();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Terima langsung objek DateFilter dari dialog
  void applyDateFilter(DateFilter filter) {
    if (filter.isLast13Months) {
      endDate = DateTime.now();
      startDate = endDate!.subtract(const Duration(days: 395)); // ~13 bulan
    } else {
      startDate = filter.startDate;
      endDate = filter.endDate;
    }
    notifyListeners();
  }

  void clearFilter() {
    startDate = null;
    endDate = null;
    notifyListeners();
  }
}
