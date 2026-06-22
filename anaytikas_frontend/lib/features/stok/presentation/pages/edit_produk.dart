import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/kategori.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/get_kategori_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/categori_dropdown.dart';
import 'package:anaytikas_frontend/features/stok/domain/entities/product_entity.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/outlined_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProduk extends StatefulWidget {
  final ProductEntity product;
  const EditProduk({super.key, required this.product});

  @override
  State<EditProduk> createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  var editStokController = TextEditingController();
  var editNamaProduct = TextEditingController();
  var editWarningStok = TextEditingController();
  var hargaJualController = TextEditingController();
  GetKategoriProvider get provider => context.read<GetKategoriProvider>();

  List<String> get _categories =>
      provider.allCategory.map((kategori) => kategori.namaKategori).toList();
  int stokValue = 0;
  Kategori? _selectedCategory;

  @override
  void initState() {
    stokValue = widget.product.jmlhStok;
    editNamaProduct = TextEditingController(text: widget.product.namaProduct);
    editStokController = TextEditingController(
      text: widget.product.jmlhStok.toString(),
    );
    editWarningStok = TextEditingController(
      text: widget.product.stokWarning.toString(),
    );
    hargaJualController = TextEditingController(
      text: widget.product.harga.hargaJual.toInt().toString(),
    );
    super.initState();
  }

  @override
  void dispose() {
    editNamaProduct.dispose();
    editStokController.dispose();
    editWarningStok.dispose();
    hargaJualController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLowStok = widget.product.jmlhStok <= widget.product.stokWarning;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Produk"),
        centerTitle: true,
        backgroundColor: AppColor.white,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(
          color: AppColor.primary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: "Rubik",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 15,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  shadowColor: AppColor.darkGray,
                  color: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColor.lowGray, width: 1),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    "Rp. ${widget.product.harga.hargaJual.toInt()}",
                                    style: TextStyle(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Jumlah Stok Saat Ini",
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
                              onPressed: () {
                                setState(() {
                                  stokValue--;
                                  editStokController.text = stokValue
                                      .toString();
                                });
                              },
                              icon: Icon(Icons.remove),
                            ),
                            Expanded(
                              child: TextField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                controller: editStokController,

                                inputFormatters: [
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Blocks letters/symbols
                                ],
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => setState(() {
                                stokValue++;
                                editStokController.text = stokValue.toString();
                              }),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Nama Barang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Ubah Nama Barang'),
                  const SizedBox(height: 6),
                  OutlinedField(
                    controller: editNamaProduct,
                    hintText: 'Contoh: Kopi Arabica 250g',
                    prefixIcon: const Icon(
                      Icons.receipt_long_outlined,
                      size: 20,
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Ubah Kategori"),
                        const SizedBox(height: 6),
                        CategoriDropdown(
                          selectedItem: _selectedCategory?.namaKategori,
                          categories: _categories,
                          onChanged: (v) {
                            setState(
                              () => _selectedCategory = provider.allCategory
                                  .firstWhere((k) => k.namaKategori == v),
                            );
                          },
                          hintTxt: "Kategori",
                          icon: Icons.category,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Warning stok
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Waring Stok Baru'),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: editWarningStok,
                          prefixIcon: const Icon(
                            Icons.production_quantity_limits_rounded,
                            size: 20,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Harga Jual Barang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('Harga Jual Baru'),
                  const SizedBox(height: 6),
                  OutlinedField(
                    controller: hargaJualController,
                    keyboardType: TextInputType.number,
                    preFixText: "Rp. ",
                  ),
                ],
              ),

              const SizedBox(height: 35),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: AppColor.white,
                      ),
                      label: const Text(
                        "Hapus Produk",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        minimumSize: const Size(0, 55),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          side: BorderSide(color: AppColor.black, width: 1),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text(
                        "Konfirmasi Edit Stok",
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
                        minimumSize: const Size(0, 55),
                      ),
                    ),
                  ),
                ],
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
