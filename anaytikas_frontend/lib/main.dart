import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/core/config/theme/app_theme.dart';
import 'package:anaytikas_frontend/features/kasir/data/datasources/kasir_local_data_source.dart';
import 'package:anaytikas_frontend/features/kasir/data/repositories/kasir_repository_impl.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_category_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_product_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/save_transaction_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:anaytikas_frontend/features/stok/data/repository/stok_repository_impl.dart';
import 'package:anaytikas_frontend/features/stok/data/sources/stok_local_datasource.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/add_barang_baru.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/add_biaya_operasional.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/add_stok.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_category.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/get_all_products.dart';
import 'package:anaytikas_frontend/features/stok/domain/usecases/update_product.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/barang_baru_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/biaya_operasional_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/edit_product_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/get_kategori_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/stok_home_provider.dart';
import 'package:anaytikas_frontend/features/stok/presentation/provider/tambah_stok_provider.dart';
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
  final stokRepo = StokRepositoryImpl(
    datasource: StokLocalDatasourceImpl(dbHelper: db),
  );
  // final
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => KasirProvider(
            getAllProduct: GetAllProductUsecase(kasirRepo),
            saveTransaction: SaveTransactionUsecase(kasirRepo),
            getAllCategory: GetAllCategoryUsecase(kasirRepo),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => StokHomeProvider(
            getAllProduct: GetAllProducts(stokRepository: stokRepo),
          )..getAllProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => BarangBaruProvider(
            addBarangBaru: AddBarangBaru(stokRepository: stokRepo),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => GetKategoriProvider(
            getAllCategory: GetAllCategory(stokRepository: stokRepo),
          )..loadCategory(),
        ),
        ChangeNotifierProvider(
          create: (_) => BiayaOperasionalProvider(
            addBiayaOperasional: AddBiayaOperasional(stokRepository: stokRepo),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProductProvider(
            updateProduct: UpdateProduct(stokRepository: stokRepo),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              TambahStokProvider(addStok: AddStok(stokRepository: stokRepo)),
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
