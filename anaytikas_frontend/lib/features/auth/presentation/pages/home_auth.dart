// lib/features/auth/presentation/pages/welcome_page.dart
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';
import 'package:anaytikas_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/features/auth/presentation/pages/login_page.dart';
import 'package:anaytikas_frontend/features/auth/presentation/pages/register_page.dart';
import 'package:provider/provider.dart';

class HomeAuth extends StatelessWidget {
  const HomeAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A2B4C),
                  ),
                  children: [
                    TextSpan(text: 'Analyti'),
                    TextSpan(
                      text: 'Kas',
                      style: TextStyle(color: AppColor.black),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/Login.png',
                height: 220,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.desktop_mac_outlined,
                  size: 160,
                  color: Color(0xFFB9C6F2),
                ),
              ),
              const Spacer(),
              const Text(
                'Pengelolaan yang Mudah untuk Toko Anda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primary,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: 18,
                    height: 4,
                    decoration: BoxDecoration(
                      color: i == 0
                          ? const Color(0xFF1A2B4C)
                          : const Color(0xFFD9DEE8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AuthProvider>().resetMessage();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2B4C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Buat Akun Baru',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<AuthProvider>().resetMessage();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1A2B4C)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Masuk',
                    style: TextStyle(
                      color: Color(0xFF1A2B4C),
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
    );
  }
}
