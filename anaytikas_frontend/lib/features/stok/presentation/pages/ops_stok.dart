import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/biaya_operasional_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/categori_dropdown.dart';
import 'package:anaytikas_frontend/features/stok/presentation/widgets/outlined_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OpsStok extends StatefulWidget {
  const OpsStok({super.key});

  @override
  State<OpsStok> createState() => _OpsStokState();
}

class _OpsStokState extends State<OpsStok> {
  final _nominalController = TextEditingController();
  final _tanggalController = TextEditingController();
  final List<String> namaBiaya = [
    'Gaji Karyawan',
    'Sewa Tempat',
    'Listrik',
    "Air",
  ];
  String? selectedBiaya;

  @override
  void dispose() {
    _nominalController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final nominal = _nominalController.text.trim();
    final tanggal = _tanggalController.text.trim();

    if (selectedBiaya == null || selectedBiaya!.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih nama biaya')));
      return;
    }

    if (nominal.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nominal tidak boleh kosong')),
      );
      return;
    }

    if (tanggal.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih tanggal')));
      return;
    }

    final provider = context.read<BiayaOperasionalProvider>();

    final nominalParse = double.tryParse(nominal);
    final tanggalParse = DateTime.tryParse(tanggal);

    if (nominalParse == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nominal tidak valid')));
      return;
    }

    if (tanggalParse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Format tanggal tidak valid')),
      );
      return;
    }

    await provider.addBiayaOps(
      idBiaya: 0,
      nama: selectedBiaya!,
      tanggal: tanggalParse,
      totalBiaya: nominalParse,
      waktu: tanggalParse,
    );

    if (mounted) {
      if (provider.succes) {
        context.read<RiwayatProvider>().loadRiwayat();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Biaya operasional berhasil ditambahkan'),
          ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label("Nama Biaya"),
                  const SizedBox(height: 7),
                  CategoriDropdown(
                    icon: Icons.list_outlined,
                    hintTxt: "Pilih Biaya...",
                    selectedItem: selectedBiaya,
                    categories: namaBiaya,
                    onChanged: (v) {
                      setState(() => selectedBiaya = v);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Nominal"),
                        const SizedBox(height: 4),
                        OutlinedField(
                          controller: _nominalController,
                          hintText: "0",
                          keyboardType: TextInputType.number,
                          prefix: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text("Rp. "),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label("Tanggal"),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.darkGray),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _tanggalController,
                            readOnly: true,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hint: Text("Tanggal"),
                              hintStyle: const TextStyle(
                                color: AppColor.lowGray,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              icon: Padding(
                                padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                                child: Icon(Icons.date_range_outlined),
                              ),
                            ),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _onSubmit,
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
                    'Biaya Operasional',
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
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.black,
    ),
  );

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(200),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _tanggalController.text = picked.toString().split(" ")[0];
      });
    }
  }
}
