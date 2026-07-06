import 'package:anaytikas_frontend/core/shared/extensions/currency_extension.dart';
import 'package:anaytikas_frontend/features/analisis/presentation/provider/analisis_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeAnalisis extends StatefulWidget {
  const HomeAnalisis({super.key});

  @override
  State<HomeAnalisis> createState() => _HomeAnalisisState();
}

dynamic provider;

class _HomeAnalisisState extends State<HomeAnalisis> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = context.read<AnalisisProvider>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<AnalisisProvider>(
        builder: (context, value, child) {
          if (value.status == Status.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (value.message != "") {
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
                          value.analisisEntitiy.bulan,
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
                        Text(
                          value.analisisEntitiy.netto.toRupiah(),
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
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                size: 16,
                                color: Color(0xFF1A2B4C),
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${value.analisisEntitiy.presentase} %",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: value.analisisEntitiy.presentase < 0
                                      ? Colors.green
                                      : Colors.redAccent,
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
                    value: value.analisisEntitiy.totalBiayaOperasional
                        .toRupiah(),
                  ),
                  const SizedBox(height: 12),
                  _buildStatCard(
                    label: 'Laba Kotor',
                    value: value.analisisEntitiy.brutto.toRupiah(),
                  ),

                  const SizedBox(height: 24),

                  // ---- Total Penjualan / Total Pembelian ----
                  Row(
                    children: [
                      Expanded(
                        child: _buildCountColumn(
                          label: 'Total Penjualan',
                          value: value.analisisEntitiy.totalPenjualan
                              .toString(),
                        ),
                      ),
                      Expanded(
                        child: _buildCountColumn(
                          label: 'Total Pembelian',
                          value: value.analisisEntitiy.totalPembelian
                              .toString(),
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
