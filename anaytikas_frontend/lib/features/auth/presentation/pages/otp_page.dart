// lib/features/auth/presentation/pages/otp_page.dart
import 'package:anaytikas_frontend/features/auth/presentation/pages/create_new_pass_page.dart';
import 'package:anaytikas_frontend/features/auth/presentation/pages/success_page.dart';
import 'package:anaytikas_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatefulWidget {
  final String email;
  final String jenisOtp;
  const OtpPage({super.key, required this.email, required this.jenisOtp});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const int _otpLength = 6;

  final List<TextEditingController> _controllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  bool _isLoading = false;
  bool _isLoad = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _maskedEmail {
    final parts = widget.email.split('@');
    if (parts.length != 2 || parts[0].isEmpty) return widget.email;
    final visible = parts[0].substring(0, parts[0].length >= 2 ? 2 : 1);
    return '$visible***@${parts[1]}';
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      // move forward to the next box
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      // backspace on an empty box moves focus back
      _focusNodes[index - 1].requestFocus();
    }
  }

  String get _otpValue => _controllers.map((c) => c.text).join();

  void _onSubmit() async {
    if (_otpValue.length < _otpLength) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan 6 digit kode OTP')),
      );
      return;
    }
    setState(() => _isLoading = true);
    // TODO: wire to AuthProvider.verifyOtp(email, _otpValue)
    if (widget.jenisOtp == 'register') {
      try {
        await context.read<AuthProvider>().validateAccount(
          int.tryParse(_otpValue)!,
        );
        print('register');
        final status = context.read<AuthProvider>().status;
        final message = context.read<AuthProvider>().message;
        if (status == Status.success) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SuccessPage(message: message)),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    } else if (widget.jenisOtp == 'forgotPass') {
      try {
        await context.read<AuthProvider>().passOtp(int.tryParse(_otpValue)!);
        final status = context.read<AuthProvider>().status;
        print('masuk forgotPass');
        if (status == Status.success) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => CreateNewPassPage()));
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  void _onResend() async {
    setState(() => _isLoad = true);
    // TODO: wire to AuthProvider.resendOtp(email)
    if (widget.jenisOtp == 'register') {
      try {
        await context.read<AuthProvider>().resedOtp();
      } finally {
        if (mounted) {
          setState(() => _isLoad = false);
        }
      }
    } else if (widget.jenisOtp == 'forgotPass') {
      try {
        await context.read<AuthProvider>().resedOtpPass();
      } finally {
        if (mounted) {
          setState(() => _isLoad = false);
        }
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
          'Masukkan Kode OTP',
          style: TextStyle(
            color: Color(0xFF1A2B4C),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              Text(
                'Kode OTP sudah di kirim ke\n$_maskedEmail',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_otpLength, (index) {
                  return SizedBox(
                    width: 48,
                    height: 56,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A2B4C),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: const Color(0xFFF5F6F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF1A2B4C),
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: (value) => _onChanged(value, index),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
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
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Tidak menerima OTP? ',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: _isLoad ? null : _onResend,
                    child: Text(
                      'Kirim ulang',
                      style: TextStyle(
                        color: _isLoad
                            ? Color(0xFF1A2B4C).withValues(alpha: 0.5)
                            : Color(0xFF1A2B4C),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
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
}
