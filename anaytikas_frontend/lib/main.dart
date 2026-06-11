import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/features/kasir/data/datasources/kasir_local_data_source.dart';
import 'package:anaytikas_frontend/features/kasir/data/repositories/kasir_repository_impl.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_product_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/save_transaction_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
// import 'package:anaytikas_frontend/features/stok/presentation/widgets/produkStokCard.dart';
import 'package:anaytikas_frontend/shared/widgets/main_sheel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding();
  final db = DatabaseHelper.instance;
  final kasirRepo = KasirRepositoryImpl(
    localDataSource: KasirLocalDataSourceImpl(dbHelper: db),
  );
  // final
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => KasirProvider(
            getAllProduct: GetAllProductUsecase(kasirRepo),
            saveTransaction: SaveTransactionUsecase(kasirRepo),
          )..loadProduct(),
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
