// import 'package:anaytikas_frontend/core/config/network/connectivity_helper.dart';
import 'package:anaytikas_frontend/features/analisis/presentation/provider/analisis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAnalisis extends StatelessWidget {
  const HomeAnalisis({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: replace with real data from AnalisisProvider once field mapping is settled
    const bulanTahun = 'MEI 2026';
    const pendapatanBersih = 'Rp.24.700.000';
    const persentase = '+ 67%';
    const biayaOperasional = 'Rp.5.200.000';
    const labaKotor = 'Rp.33.000.000';
    const totalPenjualan = '36 Penjualan';
    const totalPembelian = '44 Pembelian';
    // context.watch<AnalisisProvider>().loadAnalisis(email: '', token: '');

    return SizedBox(
      child: Consumer<AnalisisProvider>(
        builder: (context, value, child) {
          if (value.status == Status.offline) {
            return Center(child: Text(value.message));
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---- Pendapatan Bersih card ----
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromRGBO(31, 31, 31, 0.393),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bulanTahun,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'PENDAPATAN BERSIH',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          pendapatanBersih,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A2B4C),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7CF0A8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                size: 16,
                                color: Color(0xFF1A2B4C),
                              ),
                              SizedBox(width: 4),
                              Text(
                                persentase,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A2B4C),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'DIBANDINGKAN BULAN LALU',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ---- Biaya Operasional & Laba Kotor cards ----
                  _buildStatCard(
                    label: 'Biaya Operasional',
                    value: biayaOperasional,
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(label: 'Laba Kotor', value: labaKotor),

                  const SizedBox(height: 24),

                  // ---- Total Penjualan / Total Pembelian ----
                  Row(
                    children: [
                      Expanded(
                        child: _buildCountColumn(
                          label: 'Total Penjualan',
                          value: totalPenjualan,
                        ),
                      ),
                      Expanded(
                        child: _buildCountColumn(
                          label: 'Total Pembelian',
                          value: totalPembelian,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard({required String label, required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9ECF2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1A2B4C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountColumn({required String label, required String value}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A2B4C),
          ),
        ),
      ],
    );
  }
}
