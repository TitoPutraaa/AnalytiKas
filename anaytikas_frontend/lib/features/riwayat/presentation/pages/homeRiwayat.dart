import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/transaction_card.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/widgets/date_filter_dialog.dart';

class Homeriwayat extends StatefulWidget {
  const Homeriwayat({super.key});

  @override
  State<Homeriwayat> createState() => _HomeriwayatState();
}

class _HomeriwayatState extends State<Homeriwayat> {
  // Data transaksi sample - sesuaikan dengan data dari API/Database
  final List<Map<String, dynamic>> transactions = [
    {
      'tanggal': 'Sabtu, 02 Mei 2024',
      'waktu': '10:30',
      'total': 231000.0,
      'items': [
        TransactionItem(
          namaProduct: 'Kopi Arabica 250g',
          jumlah: 1,
          harga: 10000.0,
        ),
        TransactionItem(
          namaProduct: 'Beras Putri 12kg',
          jumlah: 1,
          harga: 210000.0,
        ),
      ],
    },
    {
      'tanggal': 'Rabu, 03 Mei 2024',
      'waktu': '14:15',
      'total': 35000.0,
      'items': [
        TransactionItem(namaProduct: 'Telur Ayam', jumlah: 2, harga: 3000.0),
        TransactionItem(
          namaProduct: 'Peppodent Kecil',
          jumlah: 1,
          harga: 8000.0,
        ),
      ],
    },
    {
      'tanggal': 'Jumat, 04 Mei 2024',
      'waktu': '09:45',
      'total': 27000.0,
      'items': [
        TransactionItem(
          namaProduct: 'Mie Sedap Goreng',
          jumlah: 3,
          harga: 3000.0,
        ),
        TransactionItem(
          namaProduct: 'Minyak Filma 1L',
          jumlah: 1,
          harga: 20000.0,
        ),
      ],
    },
    {
      'tanggal': 'Minggu, 05 Mei 2024',
      'waktu': '16:20',
      'total': 12000.0,
      'items': [
        TransactionItem(namaProduct: 'Teh Pucuk', jumlah: 2, harga: 4000.0),
        TransactionItem(namaProduct: 'Susu Ultramik', jumlah: 1, harga: 8000.0),
      ],
    },
  ];

  DateTime? filterStartDate;
  DateTime? filterEndDate;
  bool isFiltered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Riwayat Transaksi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColor.darkGray,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: GestureDetector(
                onTap: () => _showFilterDialog(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isFiltered ? AppColor.primary : Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_list,
                        color: isFiltered ? AppColor.primary : AppColor.lowGray,
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 12,
                          color: isFiltered
                              ? AppColor.primary
                              : AppColor.lowGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Info filter jika aktif
          if (isFiltered)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    filterStartDate != null && filterEndDate != null
                        ? '${_formatDate(filterStartDate!)} - ${_formatDate(filterEndDate!)}'
                        : 'Filter diterapkan',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColor.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFiltered = false;
                        filterStartDate = null;
                        filterEndDate = null;
                      });
                    },
                    child: const Text(
                      'Hapus filter',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // List transaksi
          Expanded(
            child: transactions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt, size: 64, color: AppColor.lowGray),
                        const SizedBox(height: 16),
                        const Text(
                          'Tidak ada transaksi',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.darkGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Mulai lakukan transaksi untuk melihat riwayat',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColor.lowGray,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return TransactionCard(
                        tanggal: transaction['tanggal'],
                        waktu: transaction['waktu'],
                        items: transaction['items'],
                        totalHarga: transaction['total'],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DateFilterDialog(
          onApply: (DateFilter filter) {
            setState(() {
              isFiltered = true;
              filterStartDate = filter.startDate;
              filterEndDate = filter.endDate;
            });
          },
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}
