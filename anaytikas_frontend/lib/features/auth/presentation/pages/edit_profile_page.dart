// lib/features/auth/presentation/pages/ubah_profil_toko_page.dart
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // TODO: pre-fill from TokoProvider once domain layer exists
  late final _namaTokoController = TextEditingController(
    text: 'Toko Suka Suka',
  );
  late final _noTelpController = TextEditingController(text: '081452384425');
  late final _alamatController = TextEditingController(
    text: 'Jl. Kampung Durian Runtuh',
  );

  @override
  void dispose() {
    _namaTokoController.dispose();
    _noTelpController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  String? _required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName wajib diisi';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'No. telepon wajib diisi';
    final phoneRegex = RegExp(r'^[0-9]{9,13}$');
    if (!phoneRegex.hasMatch(value.trim()))
      return 'Format no. telepon tidak valid';
    return null;
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    // TODO: wire to TokoProvider.updateProfile(
    //   namaToko: _namaTokoController.text.trim(),
    //   noTelp: _noTelpController.text.trim(),
    //   alamat: _alamatController.text.trim(),
    // );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil toko berhasil diperbarui')),
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Ubah Profil Toko',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kelola informasi identitas dan kontak operasional toko Anda.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 24),

                _buildLabel('Nama Toko'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _namaTokoController,
                  validator: (v) => _required(v, 'Nama toko'),
                  decoration: _inputDecoration(icon: Icons.storefront_outlined),
                ),
                const SizedBox(height: 20),

                _buildLabel('No. Telepon'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _noTelpController,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                  decoration: _inputDecoration(icon: Icons.call_outlined),
                ),
                const SizedBox(height: 20),

                _buildLabel('Alamat'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _alamatController,
                  maxLines: 2,
                  validator: (v) => _required(v, 'Alamat'),
                  decoration: _inputDecoration(
                    icon: Icons.location_on_outlined,
                  ),
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: _onSubmit,
                    icon: const Icon(
                      Icons.save_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    label: const Text(
                      'Simpan Perubahan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A2B4C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: Color(0xFF1A2B4C),
    ),
  );

  InputDecoration _inputDecoration({required IconData icon}) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      filled: true,
      fillColor: const Color(0xFFF5F6F9),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
