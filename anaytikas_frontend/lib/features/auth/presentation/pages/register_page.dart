// lib/features/auth/presentation/pages/register_page.dart
import 'package:anaytikas_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/features/auth/presentation/pages/otp_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _namaTokoController = TextEditingController();
  final _phoneController = TextEditingController();
  final _alamatController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _namaTokoController.dispose();
    _phoneController.dispose();
    _alamatController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _required(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) return '$fieldName wajib diisi';
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Format email tidak valid';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'No. telepon wajib diisi';
    final phoneRegex = RegExp(r'^[0-9]{9,13}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Format no. telepon tidak valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Kata sandi wajib diisi';
    if (value.length < 8) return 'Setidaknya 8 karakter';
    return null;
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    // TODO: wire to AuthProvider.register(...) once domain layer exists
    try {
      await context.read<AuthProvider>().createAccount(
        _emailController.text.trim(),
        _namaTokoController.text,
        _phoneController.text,
        _alamatController.text,
        _passwordController.text,
      );
      final status = context.read<AuthProvider>().status;
      if (status == Status.success) {
        context.read<AuthProvider>().resetMessage();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OtpPage(
              email: _emailController.text.trim(),
              jenisOtp: 'register',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A2B4C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Buat Akun Baru',
          style: TextStyle(
            color: Color(0xFF1A2B4C),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lengkapi formulir pendaftaran di bawah ini untuk membuat akun baru.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2B4C),
                  ),
                ),
                const SizedBox(height: 24),

                Selector<AuthProvider, String?>(
                  selector: (_, provider) =>
                      provider.status == Status.error ? provider.message : null,
                  builder: (context, message, child) {
                    if (message == null) return const SizedBox.shrink();

                    return Text(
                      message,
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    );
                  },
                ),
                _buildLabel('Email'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  decoration: _inputDecoration(
                    hint: 'contohemail@gmail.com',
                    icon: Icons.mail_outline,
                  ),
                ),
                const SizedBox(height: 18),

                _buildLabel('Nama Toko'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _namaTokoController,
                  validator: (v) => _required(v, 'Nama toko'),
                  decoration: _inputDecoration(
                    hint: 'Nama Toko Anda',
                    icon: Icons.storefront_outlined,
                  ),
                ),
                const SizedBox(height: 18),

                _buildLabel('No. Telepon'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: _validatePhone,
                  decoration: _inputDecoration(
                    hint: '0821112223333',
                    icon: Icons.call_outlined,
                  ),
                ),
                const SizedBox(height: 18),

                _buildLabel('Alamat'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _alamatController,
                  validator: (v) => _required(v, 'Alamat'),
                  decoration: _inputDecoration(
                    hint: 'Alamat Toko Anda',
                    icon: Icons.location_on_outlined,
                  ),
                ),
                const SizedBox(height: 18),

                _buildLabel('Kata Sandi'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                  decoration: _inputDecoration(
                    hint: 'Setidaknya 8 karakter',
                    icon: Icons.lock_outline,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _onSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A2B4C),
                      disabledBackgroundColor: const Color(
                        0xFF1A2B4C,
                      ).withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Buat Akun',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
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

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      prefixIcon: Icon(icon, color: Colors.grey, size: 20),
      suffixIcon: suffixIcon,
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
