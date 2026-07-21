import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/core/shared/extensions/currency_extension.dart';
import 'package:anaytikas_frontend/core/shared/formatter/currency_input_formatter.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/pembelian.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/tambah_stok_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/outlined_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Tambahstok extends StatefulWidget {
  final ProductEntity product;

  const Tambahstok({super.key, required this.product});

  @override
  State<Tambahstok> createState() => _TambahstokState();
}

class _TambahstokState extends State<Tambahstok> {
  var stokBaruController = TextEditingController();
  var hargaBeliController = TextEditingController();
  int stokValue = 0;

  @override
  void initState() {
    super.initState();
    stokBaruController.text = stokValue.toString();
    hargaBeliController = TextEditingController(
      text: widget.product.harga.hargaBeli.toThoushandsSeparator().toString(),
    );
  }

  @override
  void dispose() {
    stokBaruController.dispose();
    hargaBeliController.dispose();
    super.dispose();
  }

  Future<void> _onConfirm() async {
    final jumlah = int.tryParse(stokBaruController.text.trim()) ?? 0;

    if (jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah stok harus lebih dari 0')),
      );
      return;
    }

    String cleanValueBeli = hargaBeliController.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    final hargaBeli =
        double.tryParse(cleanValueBeli) ?? widget.product.harga.hargaBeli;

    final now = DateTime.now();
    final pembelian = Pembelian(
      idPembelian: 0,
      tanggal: now,
      waktu:
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
      totalHarga: hargaBeli * jumlah,
    );

    final provider = context.read<TambahStokProvider>();
    await provider.add(pembelian, widget.product, jumlah);

    if (mounted) {
      if (provider.status == Status.success) {
        context.read<KasirProvider>().loadProduct();
        context.read<RiwayatProvider>().loadRiwayat();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Stok berhasil ditambahkan')),
        );
        Navigator.of(context).pop(true);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(provider.message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLowStok = widget.product.jmlhStok <= widget.product.stokWarning;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Stok"),
        centerTitle: true,
        backgroundColor: AppColor.white,
        toolbarHeight: 60,
        titleTextStyle: const TextStyle(
          color: AppColor.primary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: "Rubik",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shadowColor: AppColor.darkGray,
                      color: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(
                          color: AppColor.lowGray,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.product.namaProduct,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Kode Barang: ${widget.product.idProduct}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Kategori: ${widget.product.kategori.namaKategori}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "Rp ${widget.product.harga.hargaJual.toThoushandsSeparator()}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // --- Stok produk
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "STOK",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${widget.product.jmlhStok}",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: isLowStok
                                              ? Colors.red
                                              : Colors.green.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // input stock card
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Jumlah Stok Baru",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.darkGray),
                          ),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => setState(() {
                                  if (stokValue > 0) stokValue--;
                                  stokBaruController.text = stokValue
                                      .toString();
                                }),
                                icon: const Icon(Icons.remove),
                              ),
                              Expanded(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  controller: stokBaruController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                  ),
                                  onChanged: (v) {
                                    stokValue = int.tryParse(v) ?? 0;
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () => setState(() {
                                  stokValue++;
                                  stokBaruController.text = stokValue
                                      .toString();
                                }),
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // form
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label('Harga Beli Per Satuan'),
                            const SizedBox(height: 6),
                            OutlinedField(
                              controller: hargaBeliController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [CurrencyInputFormatter()],
                              preFixText: "Rp.",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Confirm button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel_outlined,
                              color: AppColor.primary,
                            ),
                            label: const Text(
                              "Batal",
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              minimumSize: const Size(0, 55),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                  color: AppColor.black,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: Consumer<TambahStokProvider>(
                            builder: (context, provider, child) {
                              return ElevatedButton.icon(
                                onPressed: provider.status == Status.loading
                                    ? null
                                    : _onConfirm,
                                icon: provider.status == Status.loading
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColor.white,
                                        ),
                                      )
                                    : const Icon(Icons.check_circle_outline),
                                label: const Text(
                                  "Konfirmasi Tambah Stok",
                                  style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.fromLTRB(
                                    20,
                                    5,
                                    10,
                                    5,
                                  ),
                                  minimumSize: const Size(0, 55),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
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
