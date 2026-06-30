// ============================================
// data/repositories/riwayat_repository_impl.dart
// ============================================
import 'package:anaytikas_frontend/features/riwayat/data/datasources/riwayat_local_data_source.dart';
import 'package:anaytikas_frontend/features/riwayat/data/models/riwayat_operasional_model.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:collection/collection.dart';
import '../../domain/repositories/riwayat_repository.dart';
import '../models/riwayat_penjualan_row_model.dart';
import '../models/riwayat_pembelian_row_model.dart';

class RiwayatRepositoryImpl implements RiwayatRepository {
  final RiwayatLocalDataSource localDataSource;

  RiwayatRepositoryImpl({required this.localDataSource});

  @override
  Future<List<RiwayatEntryEntity>> getRiwayat() async {
    final penjualan = await _getPenjualanEntries();
    final pembelian = await _getPembelianEntries();
    final biaya = await _getBiayaEntries();

    final all = <RiwayatEntryEntity>[...penjualan, ...pembelian, ...biaya];

    all.sort((a, b) {
      final cmp = b.tanggal.compareTo(a.tanggal);
      if (cmp != 0) return cmp;
      return b.waktu.compareTo(a.waktu);
    });

    return all;
  }

  // --- Penjualan: Map -> Model -> Entity (grouped) ---

  Future<List<RiwayatPenjualan>> _getPenjualanEntries() async {
    final rawRows = await localDataSource.getRiwayatPenjualan();

    // Map -> Model
    final models = rawRows
        .map((map) => RiwayatPenjualanRowModel.fromMap(map))
        .toList();

    // Model (flat) -> Entity (nested, grouped per id_penjualan)
    final grouped = groupBy(
      models,
      (RiwayatPenjualanRowModel m) => m.idPenjualan,
    );

    return grouped.entries.map((entry) {
      final rows = entry.value;
      final first = rows.first;

      return RiwayatPenjualan(
        idPenjualan: first.idPenjualan,
        tanggal: first.tanggal,
        waktu: first.waktu,
        totalItem: first.totalItem,
        totalHarga: first.totalHarga,
        namaToko: first.namaToko,
        alamat: first.alamat,
        items: rows
            .map(
              (r) => ItemDetail(
                namaProduct: r.namaProduct,
                jumlah: r.jumlah,
                satuan: r.satuan,
                totalHargaPerProduct: r.totalHargaPerProduct,
              ),
            )
            .toList(),
      );
    }).toList();
  }

  // --- Pembelian: Map -> Model -> Entity (grouped) ---

  Future<List<RiwayatPembelian>> _getPembelianEntries() async {
    final rawRows = await localDataSource.getRiwayatPembelian();

    final models = rawRows
        .map((map) => RiwayatPembelianRowModel.fromMap(map))
        .toList();

    return models.map((m) {
      return RiwayatPembelian(
        idPembelian: m.idPembelian,
        tanggal: m.tanggal,
        waktu: m.waktu,
        totalHarga: m.totalHarga,
        namaProduct: m.namaProduct,
        jumlah: m.jumlah,
        satuan: m.satuan,
      );
    }).toList();
  }

  // --- Biaya: Map -> Model -> Entity (langsung, tanpa grouping) ---

  Future<List<RiwayatOperasional>> _getBiayaEntries() async {
    final rawRows = await localDataSource.getRiwayatBiayaOperasional();

    final models = rawRows
        .map((map) => RiwayatOperasionalModel.fromMap(map))
        .toList();

    return models
        .map(
          (m) => RiwayatOperasional(
            idBiaya: m.idBiaya,
            tanggal: m.tanggal,
            waktu: m.waktu,
            namaBiaya: m.namaBiaya,
            totalBiaya: m.totalBiaya,
          ),
        )
        .toList();
  }
}
