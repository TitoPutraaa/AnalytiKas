import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/core/di/get_it.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/cart_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/nota_penjualan_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/barang_baru_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/biaya_operasional_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/edit_product_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/get_kategori_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/tambah_stok_provider.dart';
import 'package:anaytikas_frontend/shared/widgets/main_sheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        ChangeNotifierProvider(create: (_) => getIt<StokHomeProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<GetKategoriProvider>()),
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.mainTheme,
        home: const MainSheel(),
      ),
    );
  }
}
