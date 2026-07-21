import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/core/shared/formatter/currency_input_formatter.dart';
// import 'package:anaytikas_frontend/core/shared/entities/pembelian_entity.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
// import 'package:anaytikas_frontend/features/kasir/presentation/pages/camera_scanner_page.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/harga_product.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/barang_baru_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/get_kategori_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/camera_scan.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/categori_dropdown.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/outlined_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BarangBaru extends StatefulWidget {
  const BarangBaru({super.key});

  @override
  State<BarangBaru> createState() => _BarangBaruState();
}

class _BarangBaruState extends State<BarangBaru> {
  final _namaBarangController = TextEditingController();
  final _warningStok = TextEditingController();
  final _jumlahStok = TextEditingController();
  final _hargaJualController = TextEditingController(text: "0");
  final _hargaBeliController = TextEditingController(text: "0");
  final _kodeBarangController = TextEditingController();
  GetKategoriProvider get provider => context.read<GetKategoriProvider>();

  List<String> get _categories =>
      provider.allCategory.map((kategori) => kategori.namaKategori).toList();
  Kategori? _selectedCategory;
  final List<String> _satuan = [
    'Krat',
    'Dus',
    "Pcs",
    'Renteng',
    'Bal',
    'lusin',
  ];
  String? _selectedSatuan;
  // final bool _isGrosir = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetKategoriProvider>().loadCategory();
    });
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    _jumlahStok.dispose();
    _warningStok.dispose();
    _hargaJualController.dispose();
    _hargaBeliController.dispose();
    _kodeBarangController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _namaBarangController.text.trim();
    final hargaBeliText = _hargaBeliController.text.trim();
    final hargaJualText = _hargaJualController.text.trim();
    final jumlahStokText = _jumlahStok.text.trim();
    final warningStokText = _warningStok.text.trim();
    final kodeBarang = _kodeBarangController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama Barang tidak boleh kosong')),
      );
      return;
    }
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih Kategori')));
      return;
    }
    if (_selectedSatuan == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih Satuan')));
      return;
    }

    if (hargaBeliText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harga Beli tidak boleh kosong')),
      );
      return;
    }

    if (hargaJualText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harga Jual tidak boleh kosong')),
      );
      return;
    }

    if (jumlahStokText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah Stok tidak boleh kosong')),
      );
      return;
    }

    if (warningStokText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Warning Stok tidak boleh kosong')),
      );
      return;
    }

    if (kodeBarang.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode Barang tidak boleh kosong')),
      );
      return;
    }

    final provider = context.read<BarangBaruProvider>();

    String cleanValueBeli = hargaBeliText.replaceAll(RegExp(r'[^0-9]'), '');
    String cleanValueJual = hargaJualText.replaceAll(RegExp(r'[^0-9]'), '');

    final hargaBeli = double.tryParse(cleanValueBeli) ?? 0.0;
    final hargaJual = double.tryParse(cleanValueJual) ?? 0.0;
    final jmlhStok = int.tryParse(jumlahStokText) ?? 0;
    final stokWarning = int.tryParse(warningStokText) ?? 0;
    final kodeBarangConv = int.tryParse(kodeBarang) ?? 0;

    final harga = HargaProduct(
      idHarga: 0,
      hargaJual: hargaJual,
      hargaBeli: hargaBeli,
      satuan: _selectedSatuan!,
    );

    final pemebelian = Pembelian(
      idPembelian: 0,
      tanggal: DateTime.now(),
      waktu: "",
      totalHarga: jmlhStok * hargaBeli,
    );

    final product = ProductEntity(
      idProduct: kodeBarangConv,
      kategori: _selectedCategory!,
      harga: harga,
      namaProduct: name,
      jmlhStok: jmlhStok,
      stokWarning: stokWarning,
    );

    await provider.barangBaru(
      pembelian: pemebelian,
      product: product,
      jumlah: jmlhStok,
    );

    if (mounted) {
      if (provider.status == Status.success) {
        context.read<KasirProvider>().loadProduct();
        context.read<RiwayatProvider>().loadRiwayat();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Barang baru berhasil ditambahkan')),
        );
        Navigator.of(context).pop(true);
      } else if (provider.status == Status.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(provider.message)));
      }
    }
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Nama Barang'),
                  const SizedBox(height: 6),
                  OutlinedField(
                    controller: _namaBarangController,
                    hintText: 'Contoh: Kopi Arabica 250g',
                    prefixIcon: const Icon(
                      Icons.receipt_long_outlined,
                      size: 20,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              //  Kategori
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Kategori'),
                        const SizedBox(height: 6),
                        CategoriDropdown(
                          icon: Icons.category_outlined,
                          hintTxt: "Pilih Kategori...",
                          selectedItem: _selectedCategory?.namaKategori,
                          categories: _categories,
                          onChanged: (v) {
                            setState(() {
                              _selectedCategory = provider.allCategory
                                  .firstWhere((k) => k.namaKategori == v);
                              // print(_selectedCategory.namaKategori);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Satuan'),
                        const SizedBox(height: 6),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.darkGray),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSatuan,
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Satuan",
                                      style: TextStyle(
                                        color: AppColor.lowGray,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.lowGray,
                                size: 20,
                              ),
                              dropdownColor: AppColor.white,
                              borderRadius: BorderRadius.circular(10),
                              items: _satuan
                                  .map(
                                    (c) => DropdownMenuItem(
                                      value: c,
                                      child: Text(
                                        c,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: AppColor.primary,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                setState(() => _selectedSatuan = v);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     _label('Grosir'),
                  //     const SizedBox(height: 10),
                  //     Switch(
                  //       value: _isGrosir,
                  //       onChanged: (v) => setState(() => _isGrosir = v),
                  //       activeThumbColor: AppColor.white,
                  //       activeTrackColor: AppColor.primary,
                  //       inactiveThumbColor: AppColor.white,
                  //       inactiveTrackColor: AppColor.darkGray,
                  //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              const SizedBox(height: 16),

              //  Harga Jual dan Beli
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Harga Beli'),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _hargaBeliController,
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          inputFormatters: [CurrencyInputFormatter()],
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 14, right: 4),
                            child: Text(
                              'Rp.',
                              style: TextStyle(
                                color: AppColor.lowGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Harga Jual'),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _hargaJualController,
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          inputFormatters: [CurrencyInputFormatter()],
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 14, right: 4),
                            child: Text(
                              'Rp.',
                              style: TextStyle(
                                color: AppColor.lowGray,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              //  Jumlah Barang
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Jumlah Stok'),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _jumlahStok,
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Warning Stok'),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _warningStok,
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              //  Kode Barang
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 0,
                    child: Column(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColor.black),
                            padding: EdgeInsets.zero,
                            fixedSize: const Size(10, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Icon(
                            Icons.document_scanner_rounded,
                            size: 25,
                          ),
                          onPressed: () async {
                            final scannedValue = await Navigator.of(context)
                                .push<String>(
                                  MaterialPageRoute(
                                    builder: (_) => const CameraScan(),
                                  ),
                                );

                            if (scannedValue != null && mounted) {
                              setState(() {
                                _kodeBarangController.text = scannedValue;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Kode Barang'),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _kodeBarangController,
                          hintText: '56456185',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              //  Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _submit,
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
