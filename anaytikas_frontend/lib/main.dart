import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/core/di/get_it.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/token_local_data_source.dart';
import 'package:anaytikas_frontend/features/analisis/presentation/provider/analisis_provider.dart';
import 'package:anaytikas_frontend/features/auth/presentation/pages/home_auth.dart';
import 'package:anaytikas_frontend/features/auth/presentation/pages/login_page.dart';
import 'package:anaytikas_frontend/features/auth/presentation/provider/auth_provider.dart';
import 'package:anaytikas_frontend/features/auth/presentation/provider/profile_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/cart_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/nota_penjualan_provider.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/barang_baru_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/biaya_operasional_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/edit_product_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/get_kategori_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/tambah_stok_provider.dart';
import 'package:anaytikas_frontend/shared/widgets/main_sheel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

// TEST
import 'core/shared/domain/presentation/manager/register_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkToken() async {
    final tokenLocal = TokenLocalDataSourceImpl(
      secureStorage: const FlutterSecureStorage(),
    );
    final token = await tokenLocal.getToken();
    print(token);
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // kasir
        ChangeNotifierProvider(
          create: (_) => getIt<KasirProvider>()
            ..loadProduct()
            ..loadCategory(),
        ),
        ChangeNotifierProvider(create: (_) => getIt<CartProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<NotaPenjualanProvider>()),

        // stok
        ChangeNotifierProvider(create: (_) => getIt<BarangBaruProvider>()),
        ChangeNotifierProvider(
          create: (_) => getIt<BiayaOperasionalProvider>(),
        ),
        ChangeNotifierProvider(create: (_) => getIt<EditProductProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<TambahStokProvider>()),
        ChangeNotifierProvider(
          create: (_) => getIt<StokHomeProvider>()..getAllProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<GetKategoriProvider>()..loadCategory(),
        ),

        // riwayat
        ChangeNotifierProvider(
          create: (_) => getIt<RiwayatProvider>()..loadRiwayat(),
        ),

        // Auth
        ChangeNotifierProvider(create: (_) => getIt<ProfileProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
        // TEST
        ChangeNotifierProvider(create: (_) => getIt<RegisterProvider>()),
        // Analisis
        ChangeNotifierProvider(
          create: (_) => getIt<AnalisisProvider>()..loadAnalisis(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.mainTheme,
        home: FutureBuilder<bool>(
          future: _checkToken(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.data == true) {
              return const MainSheel();
            }
            return const HomeAuth();
          },
        ),
      ),
      // home: isToken ? MainSheel() : MainSheel(),
      // home: isToken ? HomeAuth() : HomeAuth(),
    );
  }
}
