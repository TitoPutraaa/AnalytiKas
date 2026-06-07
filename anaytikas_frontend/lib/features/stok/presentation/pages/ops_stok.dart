import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/categori_dropdown.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/outlined_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OpsStok extends StatefulWidget {
  const OpsStok({super.key});

  @override
  State<OpsStok> createState() => _OpsStokState();
}

class _OpsStokState extends State<OpsStok> {
  final _namaBiayaController = TextEditingController();
  final _nominalController = TextEditingController();
  final _tanggalController = TextEditingController();
  final List<String> categories = ['Makanan', 'Minuman', 'Rokok Lur'];
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        leading: const BackButton(color: AppColor.primary),
        title: const Text(
          'Biaya Operasional',
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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.darkGray),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _label("Nama Biaya"),
                  const SizedBox(height: 16),
                  CategoriDropdown(
                    selectedItem: selectedCategory,
                    categories: categories,
                    onChanged: (v) {
                      setState(() => selectedCategory = v);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Nominal"),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _nominalController,
                          hintText: "0",
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Tanggal"),
                        const SizedBox(height: 6),
                        OutlinedField(
                          controller: _tanggalController,
                          hintText: "",
                          keyboardType: TextInputType.number,
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
    );
  }
}

Widget _label(String text) => Text(
  text,
  style: const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
  ),
);
