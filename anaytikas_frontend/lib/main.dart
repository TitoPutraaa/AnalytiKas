import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/features/kasir/data/datasources/kasir_local_data_source.dart';
import 'package:anaytikas_frontend/features/kasir/data/repositories/kasir_repository_impl.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_category_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_product_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_nota_penjualan_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/save_transaction_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/cart_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/nota_penjualan_provider.dart';
// import 'package:anaytikas_frontend/features/stok/presentation/widgets/produkStokCard.dart';
import 'package:anaytikas_frontend/shared/widgets/main_sheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  final db = DatabaseHelper.instance;
  final kasirRepo = KasirRepositoryImpl(
    localDataSource: KasirLocalDataSourceImpl(dbHelper: db),
  );
  // final
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              KasirProvider(
                  getAllProduct: GetAllProductUsecase(kasirRepo),
                  saveTransaction: SaveTransactionUsecase(kasirRepo),
                  getAllCategory: GetAllCategoryUsecase(kasirRepo),
                )
                ..loadProduct()
                ..loadCategory(),
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(
          create: (_) => NotaPenjualanProvider(
            getNotaPenjualan: GetNotaPenjualanUsecase(kasirRepo),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.mainTheme,

      home: MainSheel(),
    );
  }
}
