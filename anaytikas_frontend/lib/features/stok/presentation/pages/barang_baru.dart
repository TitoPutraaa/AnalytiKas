import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/categori_dropdown.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/outlined_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BarangBaru extends StatefulWidget {
  const BarangBaru({super.key});

  @override
  State<BarangBaru> createState() => _BarangBaruState();
}

class _BarangBaruState extends State<BarangBaru> {
  final _namaBarangController = TextEditingController();
  final _jumlahBarangController = TextEditingController();
  final _hargaJualController = TextEditingController();
  final _kodeBarangController = TextEditingController(text: '56456185');

  final List<String> _categories = ['Makanan', 'Minuman', 'Rokok Lur'];
  String? _selectedCategory;
  bool _isGrosir = false;

  @override
  void dispose() {
    _namaBarangController.dispose();
    _jumlahBarangController.dispose();
    _hargaJualController.dispose();
    _kodeBarangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: const BackButton(color: AppColor.primary),
        title: const Text(
          'Tambah Barang Baru',
          style: TextStyle(
            color: AppColor.primary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.darkGray.withValues()),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Nama Barang ─
              _label('Nama Barang'),
              const SizedBox(height: 6),
              OutlinedField(
                controller: _namaBarangController,
                hintText: 'Contoh: Kopi Arabica 250g',
                prefixIcon: const Icon(Icons.receipt_long_outlined, size: 20),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 16),

              //  Kategori + Grosir toggle (belom logic togle cuyy)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Kategori'),
                        const SizedBox(height: 6),
                        CategoriDropdown(
                          icon: Icons.category_outlined,
                          hintTxt: "Pilih Kategori...",
                          selectedItem: _selectedCategory,
                          categories: _categories,
                          onChanged: (v) {
                            setState(() => _selectedCategory = v);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Grosir'),
                      const SizedBox(height: 10),
                      Switch(
                        value: _isGrosir,
                        onChanged: (v) => setState(() => _isGrosir = v),
                        activeThumbColor: AppColor.white,
                        activeTrackColor: AppColor.primary,
                        inactiveThumbColor: AppColor.white,
                        inactiveTrackColor: AppColor.darkGray,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //  Jumlah Barang
              _label('Jumlah Barang (Satuan)'),
              const SizedBox(height: 6),
              OutlinedField(
                controller: _jumlahBarangController,
                hintText: '0',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),

              //  Harga Jual ─
              _label('Harga Jual (Satuan)'),
              const SizedBox(height: 6),
              OutlinedField(
                controller: _hargaJualController,
                hintText: '0',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 4),
                  child: Text(
                    'Rp',
                    style: TextStyle(
                      color: AppColor.lowGray,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              //  Kode Barang
              _label('Kode Barang'),
              const SizedBox(height: 6),
              OutlinedField(
                controller: _kodeBarangController,
                hintText: '56456185',
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: AppColor.lowGray,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              //  Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: Navigator.of(context).pop,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.add_circle_outline, size: 20),
                  label: const Text(
                    'Tambah Barang',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: AppColor.black,
    ),
  );
}
