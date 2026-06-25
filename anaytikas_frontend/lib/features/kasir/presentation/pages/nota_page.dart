import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/theme/app_color.dart';
import '../../../../core/shared/extensions/currency_extension.dart';
import '../../../../core/shared/extensions/datetime_extension.dart';
import '../../../../shared/widgets/main_sheel.dart';
import '../manager/nota_penjualan_provider.dart';
import '../widgets/detail_transaksi_item.dart';
import '../widgets/detail_transaksi_toko_item.dart';
import '../widgets/total_bayar_item.dart';

class NotaPage extends StatefulWidget {
  final int idPenjualan;
  const NotaPage({super.key, required this.idPenjualan});

  @override
  State<NotaPage> createState() => _NotaPageState();
}

class _NotaPageState extends State<NotaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotaPenjualanProvider>().getNotaPenjualanById(
        widget.idPenjualan,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          'Rincian Transaksi',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Consumer<NotaPenjualanProvider>(
          builder: (context, nota, child) {
            final notaDetail = nota.notaPenjualan;
            if (nota.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (notaDetail == null) {
              return Center(child: Text('Nota Bermasalah '));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    const Text(
                      'TRANSAKSI BERHASIL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Terima kasih atas kunjungan Anda',
                      style: TextStyle(color: AppColor.darkGray),
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'TANGGAL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.7),
                      ),
                    ),
                    Text(
                      'ID TRANSAKSI',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tanggal
                    Text(
                      DateTime.parse(notaDetail.penjualan.tanggal).toFullDate(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.9),
                      ),
                    ),
                    // Id Penjualan
                    Text(
                      '${notaDetail.penjualan.idPenjualan}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColor.darkGray.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),

                const Divider(height: 25),
                const SizedBox(height: 10),
                TotalBayarItem(
                  totalSeluruhHarga: notaDetail.penjualan.totalHarga,
                ),
                SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Uang Diterima',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.9),
                            ),
                          ),
                          Text(
                            context.read<KasirProvider>().uangMasuk.toRupiah(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kembalian',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.9),
                            ),
                          ),
                          Text(
                            context
                                .read<KasirProvider>()
                                .uangKembali
                                .toRupiah(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Metode Pembayaran',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.7),
                            ),
                          ),
                          Text(
                            'Cash',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkGray.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Detail Transaksi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),

                SizedBox(height: 15),
                DetailTransaksiTokoItem(
                  namaToko: notaDetail.namaToko,
                  alamat: notaDetail.alamat,
                ),

                Divider(height: 45),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: notaDetail.products.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final products = notaDetail.products[index];
                    return DetailTransaksiItem(
                      namaProduct: products.namaProduct,
                      quantity: products.jumlah,
                      satuan: products.satuan,
                      totalHarga: products.totalHargaProduct,
                    );
                  },
                ),

                const SizedBox(height: 120),
              ],
            );
          },
        ),
      ),

      bottomSheet: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppColor.lowGray.withValues(alpha: 0.1),
                blurRadius: 2,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainSheel()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kembali ke Beranda',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
