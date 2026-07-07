import 'package:anaytikas_frontend/features/riwayat/domain/entities/riwayat_entry_entity.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/biaya_operasional_card.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/pembelian_card.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/penjualan_card.dart';
import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/date_filter_dialog.dart';
import 'package:provider/provider.dart';

class Homeriwayat extends StatefulWidget {
  const Homeriwayat({super.key});

  @override
  State<Homeriwayat> createState() => _HomeriwayatState();
}

class _HomeriwayatState extends State<Homeriwayat> {
  bool isFiltered = false;

  void _showFilterDialog() {
    final provider = context.read<RiwayatProvider>();
    showDialog(
      context: context,
      builder: (_) => DateFilterDialog(
        initialStartDate: provider.startDate,
        initialEndDate: provider.endDate,
        onApply: (filter) {
          context.read<RiwayatProvider>().applyDateFilter(filter);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ── Sub-header: Tanggal & Waktu | Filter ──
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Tanggal & Waktu',
                  style: TextStyle(fontSize: 13, color: Colors.black54),
                ),
                GestureDetector(
                  onTap: _showFilterDialog,
                  child: Row(
                    children: [
                      Icon(
                        Icons.menu,
                        size: 16,
                        color: isFiltered ? AppColor.primary : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        isFiltered ? 'Filter (On)' : 'Filter',
                        style: TextStyle(
                          fontSize: 13,
                          color: isFiltered ? AppColor.primary : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFE0E0E0)),

          // ── List ──
          Expanded(
            child: Container(
              color: const Color(0xFFF5F5F5),
              child: Consumer<RiwayatProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final grouped = provider.groupedByTanggal;
                  final tanggalList = grouped.keys.toList()
                    ..sort((a, b) => b.compareTo(a));

                  if (tanggalList.isEmpty) {
                    return const Center(child: Text('Belum ada riwayat'));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    itemCount: tanggalList.length,
                    itemBuilder: (context, index) {
                      final tanggal = tanggalList[index];
                      final entries = grouped[tanggal]!;
                      // print(entries);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                            // child: Text(
                            //   _formatTanggal(tanggal),
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 16,
                            //   ),
                            // ),
                          ),
                          ...entries.map((entry) {
                            return switch (entry) {
                              RiwayatPenjualan p => PenjualanCard(data: p),
                              RiwayatPembelian b => PembelianCard(data: b),
                              RiwayatOperasional c => BiayaOperasionalCard(
                                data: c,
                              ),
                            };
                          }),
                        ],
                      );

                      // return _buildCard();
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
