import 'package:anaytikas_frontend/core/config/database/database_helper.dart';
import 'package:anaytikas_frontend/features/auth/data/repository/profile_repository_impl.dart';
import 'package:anaytikas_frontend/features/auth/data/sources/profile_local_datasource.dart';
import 'package:anaytikas_frontend/features/auth/domain/repository/profile_repository.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/edit_profile_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:anaytikas_frontend/features/auth/domain/usecases/logout_usecase.dart';
import 'package:anaytikas_frontend/features/auth/presentation/provider/profile_provider.dart';
import 'package:anaytikas_frontend/features/kasir/data/datasources/kasir_local_data_source.dart';
import 'package:anaytikas_frontend/features/kasir/data/repositories/kasir_repository_impl.dart';
import 'package:anaytikas_frontend/features/kasir/domain/repositories/kasir_repository.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_category_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_all_product_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/get_nota_penjualan_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/domain/usecases/save_transaction_usecase.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/cart_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/kasir_provider.dart';
import 'package:anaytikas_frontend/features/kasir/presentation/manager/nota_penjualan_provider.dart';
import 'package:anaytikas_frontend/features/riwayat/data/datasources/riwayat_local_data_source.dart';
import 'package:anaytikas_frontend/features/riwayat/data/repositories/riwayat_repository_impl.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/repositories/riwayat_repository.dart';
import 'package:anaytikas_frontend/features/riwayat/domain/usecases/get_riwayat_usecase.dart';
import 'package:anaytikas_frontend/features/riwayat/presentation/manager/riwayat_provider.dart';
import 'package:anaytikas_frontend/features/stok/data/repository/stok_repository_impl.dart';
import 'package:anaytikas_frontend/features/stok/data/sources/stok_local_datasource.dart';
import 'package:anaytikas_frontend/features/stok/domain/repository/stok_repository.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

// TEST
import 'package:http/http.dart' as http;
import 'package:anaytikas_frontend/core/config/api/api_helper.dart';
import '../config/network/connectivity_helper.dart';
import '../shared/data/datasources/remote_data_source.dart';
import '../shared/data/datasources/token_local_data_source.dart';
import '../shared/data/repositories/account_repository_impl.dart';
import '../shared/domain/presentation/manager/register_provider.dart';
import '../shared/domain/repositories/account_repository.dart';
import '../shared/domain/usecases/register_usecase.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  registerNetwork(); // TEST
  registerDatabase();
  registerDataSource();
  registerRepository();
  registerUseCase();
  registerProvider();
}

// TEST
void registerNetwork() {
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenLocalDataSource>(
    () => TokenLocalDataSourceImpl(secureStorage: getIt()),
  );
  getIt.registerLazySingleton<ApiHelper>(
    () => ApiHelper(
      client: getIt(),
      baseUrl: 'https://analitikas-system.vercel.app/api',
    ),
  );

  getIt.registerLazySingleton<ConnectivityHelper>(() => ConnectivityHelper());
}
// =================

void registerDatabase() {
  getIt.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
}

void registerDataSource() {
  getIt.registerLazySingleton<KasirLocalDataSource>(
    () => KasirLocalDataSourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingleton<StokLocalDatasource>(
    () => StokLocalDatasourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingleton<RiwayatLocalDataSource>(
    () => RiwayatLocalDataSourceImpl(dbHelper: getIt()),
  );
  getIt.registerLazySingleton<ProfileLocalDatasource>(
    () => ProfileLocalDatasourceImpl(databaseHelper: getIt()),
  );
}

void registerRepository() {
  getIt.registerLazySingleton<KasirRepository>(
    () => KasirRepositoryImpl(localDataSource: getIt()),
  );
  getIt.registerLazySingleton<StokRepository>(
    () => StokRepositoryImpl(datasource: getIt()),
  );
  getIt.registerLazySingleton<RiwayatRepository>(
    () => RiwayatRepositoryImpl(localDataSource: getIt()),
  );

  // TEST
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepositoryImpl(
      remoteDataSource: getIt(),
      connectivityHelper: getIt(),
      tokenLocalDataSource: getIt(),
    ),
  );
  // Auth
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(profileLocalDatasource: getIt()),
  );
}

void registerUseCase() {
  // kasir
  getIt.registerLazySingleton(() => GetAllCategoryUsecase(getIt()));
  getIt.registerLazySingleton(() => GetAllProductUsecase(getIt()));
  getIt.registerLazySingleton(() => GetNotaPenjualanUsecase(getIt()));
  getIt.registerLazySingleton(() => SaveTransactionUsecase(getIt()));

  // stok
  getIt.registerLazySingleton(() => AddBarangBaru(stokRepository: getIt()));
  getIt.registerLazySingleton(
    () => AddBiayaOperasional(stokRepository: getIt()),
  );
  getIt.registerLazySingleton(() => AddStok(stokRepository: getIt()));
  getIt.registerLazySingleton(() => UpdateProduct(stokRepository: getIt()));
  getIt.registerLazySingleton(() => GetAllCategory(stokRepository: getIt()));
  getIt.registerLazySingleton(() => GetAllProducts(stokRepository: getIt()));

  // Auth
  getIt.registerLazySingleton(
    () => GetProfileUsecase(profilRepository: getIt()),
  );
  getIt.registerLazySingleton(
    () => EditProfileUsecase(profilRepository: getIt()),
  );
  getIt.registerLazySingleton(() => LogoutUsecase(profilRepository: getIt()));

  // riwayat
  getIt.registerLazySingleton(() => GetRiwayatUsecase(getIt()));

  // TEST
  getIt.registerLazySingleton(() => RegisterUsecase(getIt()));
}

void registerProvider() {
  // kasir
  getIt.registerFactory<CartProvider>(
    () => CartProvider(),
  ); // no required parameter?
  getIt.registerFactory<KasirProvider>(
    () => KasirProvider(
      getAllProduct: getIt<GetAllProductUsecase>(),
      saveTransaction: getIt<SaveTransactionUsecase>(),
      getAllCategory: getIt<GetAllCategoryUsecase>(),
    ),
  );
  getIt.registerFactory<NotaPenjualanProvider>(
    () => NotaPenjualanProvider(
      getNotaPenjualan: getIt<GetNotaPenjualanUsecase>(),
    ),
  );

  // stok
  getIt.registerFactory<BarangBaruProvider>(
    () => BarangBaruProvider(addBarangBaru: getIt<AddBarangBaru>()),
  );
  getIt.registerFactory<BiayaOperasionalProvider>(
    () => BiayaOperasionalProvider(
      addBiayaOperasional: getIt<AddBiayaOperasional>(),
    ),
  );
  getIt.registerFactory<EditProductProvider>(
    () => EditProductProvider(updateProduct: getIt<UpdateProduct>()),
  );
  getIt.registerFactory<StokHomeProvider>(
    () => StokHomeProvider(getAllProduct: getIt<GetAllProducts>()),
  );
  getIt.registerFactory<GetKategoriProvider>(
    () => GetKategoriProvider(getAllCategory: getIt<GetAllCategory>()),
  );
  getIt.registerFactory<TambahStokProvider>(
    () => TambahStokProvider(addStok: getIt<AddStok>()),
  );

  // riwayat
  getIt.registerFactory<RiwayatProvider>(
    () => RiwayatProvider(getRiwayat: getIt<GetRiwayatUsecase>()),
  );

  // Auth
  getIt.registerFactory<ProfileProvider>(
    () => ProfileProvider(
      getProfileUsecase: getIt<GetProfileUsecase>(),
      logoutUsecase: getIt<LogoutUsecase>(),
      editProfileUsecase: getIt<EditProfileUsecase>(),
    ),
  );
}
