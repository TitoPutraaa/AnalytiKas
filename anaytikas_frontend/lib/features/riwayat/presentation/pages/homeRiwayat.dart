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

  // Data static langsung di UI
  final List<Map<String, dynamic>> _transactions = [
    {
      'tanggal': 'Sabtu, 02 Mei 2024, 10:30',
      'total': 'Rp 231.000',
      'namaItem': 'Kopi Arabica 250g',
      'jumlah': 1,
      'hargaItem': 'Rp 10.000',
    },
    {
      'tanggal': 'Rabu, 03 Mei 2024, 14:15',
      'total': 'Rp 35.000',
      'namaItem': 'Telur Ayam',
      'jumlah': 2,
      'hargaItem': 'Rp 3.000',
    },
    {
      'tanggal': 'Jumat, 04 Mei 2024, 09:45',
      'total': 'Rp 27.000',
      'namaItem': 'Mie Sedap Goreng',
      'jumlah': 3,
      'hargaItem': 'Rp 3.000',
    },
  ];

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) => DateFilterDialog(
        onApply: (filter) {
          setState(() {
            isFiltered =
                filter.isLast13Months ||
                (filter.startDate != null && filter.endDate != null);
          });
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
                      print(entries);

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

  Widget _buildCard(tx) {
    print("data $tx");
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Row atas: tanggal | TOTAL + nominal ──
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   tx['tanggal'] as String,
                //   style: const TextStyle(fontSize: 12, color: Colors.black54),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black45,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    // Text(
                    //   tx['total'] as String,
                    //   style: TextStyle(
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.bold,
                    //     color: AppColor.primary,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: Color(0xFFEEEEEE)),

          // ── Row bawah: nama item + harga ──
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   tx['namaItem'] as String,
                    //   style: const TextStyle(
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.black87,
                    //   ),
                    // ),
                    const SizedBox(height: 3),
                    // Text(
                    //   'Jumlah: ${tx['jumlah']}',
                    //   style: const TextStyle(
                    //     fontSize: 11,
                    //     color: Colors.black45,
                    //   ),
                    // ),
                  ],
                ),
                // Text(
                //   tx['hargaItem'] as String,
                //   style: TextStyle(
                //     fontSize: 13,
                //     fontWeight: FontWeight.bold,
                //     color: AppColor.primary,
                //   ),
                // ),
              ],
            ),
          ),

          // ── "+ 1 item lainnya.." ──
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
            child: const Text(
              '+ 1 item lainnya..',
              style: TextStyle(fontSize: 11, color: Colors.black45),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final data = context.read<RiwayatProvider>().loadRiwayat();
              final data2 = context.read<RiwayatProvider>().groupedByTanggal;
              print(data2);
              print(data);
            },
            child: Text("data"),
          ),
        ],
      ),
    );
  }
}
