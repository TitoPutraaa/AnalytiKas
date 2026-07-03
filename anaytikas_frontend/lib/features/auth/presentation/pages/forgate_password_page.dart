import 'package:anaytikas_frontend/features/auth/presentation/pages/otp_page.dart';
import 'package:anaytikas_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgatePasswordPage extends StatefulWidget {
  const ForgatePasswordPage({super.key});

  @override
  State<ForgatePasswordPage> createState() => _ForgatePasswordPageState();
}

class _ForgatePasswordPageState extends State<ForgatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email wajib diisi';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return 'Format email tidak valid';
    return null;
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await context.read<AuthProvider>().validateEmail(
        _emailController.text.trim(),
      );

      final status = context.read<AuthProvider>().status;
      if (status == Status.success) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => OtpPage(
              email: _emailController.text.trim(),
              jenisOtp: 'forgotPass',
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A2B4C)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Lupa Kata Sandi',
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
                  'Tuliskan email anda untuk mendapatkan kode verifikasi!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A2B4C),
                  ),
                ),
                const SizedBox(height: 28),
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

                SizedBox(height: 40),

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
                            'Kirim',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
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
      enabledBorder: OutlineInputBorder(
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
