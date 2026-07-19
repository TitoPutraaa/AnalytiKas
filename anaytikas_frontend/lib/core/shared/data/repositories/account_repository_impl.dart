import 'package:anaytikas_frontend/core/shared/data/datasources/local_data_source.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/token_local_data_source.dart';
import 'package:anaytikas_frontend/core/shared/domain/entitties/toko_entity.dart';
import 'package:anaytikas_frontend/core/shared/data/models/harga_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/kategori_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/pembelian_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/penjualan_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/product_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/product_per_pembelian_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/product_per_penjualan_model.dart';
import 'package:anaytikas_frontend/core/shared/data/models/toko_model.dart';

import '../../../config/network/connectivity_helper.dart';
import '../../domain/repositories/account_repository.dart';
import '../models/api_response.dart';
import '../datasources/remote_data_source.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RemoteDataSource remoteDataSource;
  final ConnectivityHelper connectivityHelper;
  final TokenLocalDataSource tokenLocalDataSource;
  final LocalDataSource localDataSource;

  AccountRepositoryImpl({
    required this.remoteDataSource,
    required this.connectivityHelper,
    required this.tokenLocalDataSource,
    required this.localDataSource,
  });

  @override
  Future<ApiResponse> register(String email) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.register(email);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse> registerOtp(String email, int otp) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.registerOtp(email, otp);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse> registerNewAccount(
    String email,
    String pass,
    String noTelp,
    String alamat,
    String namaToko,
  ) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.registerNewAccount(
      email,
      pass,
      noTelp,
      alamat,
      namaToko,
    );
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }

    return apiResponse;
  }

  @override
  Future<ApiResponse> login(String email, String pass) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    // TESTING =====================
    // final json = await remoteDataSource.getProduct(email, token);
    // print(json);
    // final db = await localDataSource.getPenjualan();
    // print(db);

    // return ApiResponse(data: null, message: 'message', success: false);
    // TESTING =====================

    bool syncFailed = false;

    // final json = await remoteDataSource.login(email, pass);
    // final apiResponse = ApiResponse<String>.fromJson(
    //   json,
    //   (data) => data as String,
    // );

    // if (!apiResponse.success) {
    //   throw Exception(apiResponse.message);
    // }
    // final String token = apiResponse.data!;
    // await tokenLocalDataSource.saveToken(token);
    await localDataSource.clearAllTables();
    await tokenLocalDataSource.saveToken('token');
    await localDataSource.addKategory();
    print('berhasil tambah kategori');
    await localDataSource.addDummyProducts();
    print('Berhasil tambah data product');

    // bool hargaOk = true;
    // bool kategoriOk = true;
    // bool productOk = true;
    // Ambil seluruh data dan simpan di db jika ada
    // try {
    //   await Future.wait([
    //     _syncSingle(
    //       fetch: () => remoteDataSource.getProfile(email, token),
    //       fromMap: TokoModel.fromMap,
    //       toMap: (model) => model.toMap(),
    //       save: localDataSource.saveToko,
    //     ).catchError((e) {
    //       print('Gagal sync profile: $e');
    //       return null;
    //     }),
    //     // _syncList(
    //     //   fetch: () => remoteDataSource.getKategori(email, token),
    //     //   fromMap: KategoriModel.fromMap,
    //     //   toMap: (model) => model.toMap(),
    //     //   saveList: localDataSource.saveKategori,
    //     //   tableName: 'kategori',
    //     //   idKey: 'id_kategori',
    //     // ).catchError((e) {
    //     //   print('Gagal sync kategori: $e');
    //     //   kategoriOk = false;
    //     //   return null;
    //     // }),
    //     // _syncList(
    //     //   fetch: () => remoteDataSource.getHargaProduct(email, token),
    //     //   fromMap: HargaModel.fromMap,
    //     //   toMap: (model) => model.toMap(),
    //     //   saveList: localDataSource.saveHargaProducts,
    //     //   tableName: 'harga_product',
    //     //   idKey: 'id_harga',
    //     // ).catchError((e) {
    //     //   print('Gagal sync harga: $e');
    //     //   hargaOk = false;
    //     //   return null;
    //     // }),
    //     // _syncList(
    //     //   fetch: () => remoteDataSource.getBiayaOperasi(email, token),
    //     //   fromMap: BiayaOperasionalModel.fromMap,
    //     //   toMap: (model) => model.toMap(),
    //     //   saveList: localDataSource.saveBiayaOp,
    //     //   tableName: 'biaya_operasional',
    //     //   idKey: 'id_biaya',
    //     // ).catchError((e) {
    //     //   print('Gagal sync biayaOp: $e');
    //     //   return null;
    //     // }),
    //   ], eagerError: false);

    //   // if (hargaOk && kategoriOk) {
    //   //   await _syncList(
    //   //     fetch: () => remoteDataSource.getProduct(email, token),
    //   //     fromMap: ProductModel.fromMap,
    //   //     toMap: (model) => model.toMap(),
    //   //     saveList: localDataSource.saveProducts,
    //   //   ).catchError((e) {
    //   //     print('Gagal sync product: $e');
    //   //     productOk = false;
    //   //     return null;
    //   //   });
    //   // }

    //   // await Future.wait([
    //   //   _syncList(
    //   //     fetch: () => remoteDataSource.getPembelian(email, token),
    //   //     fromMap: PembelianModel.fromMap,
    //   //     toMap: (model) => model.toMap(),
    //   //     saveList: localDataSource.savePembelian,
    //   //     tableName: 'pembelian',
    //   //     idKey: 'id_pembelian',
    //   //   ).catchError((e) {
    //   //     print('Gagal sync pembelian: $e');
    //   //     return null;
    //   //   }),
    //   //   _syncList(
    //   //     fetch: () => remoteDataSource.getPenjualan(email, token),
    //   //     fromMap: PenjualanModel.fromMap,
    //   //     toMap: (model) => model.toMap(),
    //   //     saveList: localDataSource.savePenjualan,
    //   //     tableName: 'penjualan',
    //   //     idKey: 'id_penjualan',
    //   //   ).catchError((e) {
    //   //     print('Gagal sync penjualan: $e');
    //   //     return null;
    //   //   }),
    //   // ]);

    //   // if (productOk) {
    //   //   await Future.wait([
    //   //     _syncList(
    //   //       fetch: () => remoteDataSource.getProductPerPembelian(email, token),
    //   //       fromMap: ProductPerPembelianModel.fromMap,
    //   //       toMap: (model) => model.toMap(),
    //   //       saveList: localDataSource.saveProductPerPemb,
    //   //     ).catchError((e) {
    //   //       print('Gagal sync proPerpemb: $e');
    //   //       return null;
    //   //     }),
    //   //     _syncList(
    //   //       fetch: () => remoteDataSource.getProductPerPenjualan(email, token),
    //   //       fromMap: ProductPerPenjualanModel.fromMap,
    //   //       toMap: (model) => model.toMap(),
    //   //       saveList: localDataSource.saveProductPerPenj,
    //   //     ).catchError((e) {
    //   //       print('Gagal sync proPerpenj: $e');
    //   //       return null;
    //   //     }),
    //   //   ]);
    //   // }
    // } catch (e) {
    //   syncFailed = true;
    // }
    // if (syncFailed) {
    //   print(
    //     '${apiResponse.message} (peringatan: sebagian data gagal disinkronkan)',
    //   );
    //   return ApiResponse(
    //     data: null,
    //     message:
    //         '${apiResponse.message} (peringatan: sebagian data gagal disinkronkan)',
    //     success: true,
    //   );
    // }
    print('Login berhasil');
    // return apiResponse;
    return ApiResponse(data: 'data', message: 'message', success: true);
  }

  @override
  Future<ApiResponse> logout() async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    // String email;
    // String? token;
    // try {
    //   email = await localDataSource.getEmail();
    //   token = await tokenLocalDataSource.getToken();
    //   // print("email from repo :${email}");
    //   // print("token from repo :${token}");
    // } catch (e) {
    //   throw Exception('Gagal ambil data toko / token: $e');
    // }

    // if (email.isEmpty || token == null) {
    //   throw Exception('Gagal ambil data toko dari DB');
    // }

    // // Sincroniase All Data
    // // await syncAllData();

    // final json = await remoteDataSource.logout(email, token);
    // final apiResponse = ApiResponse<String>.fromJson(
    //   json,
    //   (data) => data as String,
    // );

    // hapus data
    try {
      await localDataSource.clearAllTables();
      await tokenLocalDataSource.deleteToken();
    } catch (e) {
      print('gagal hapus data');
      throw Exception(e);
    }
    // return apiResponse;
    return ApiResponse(data: 'data', message: 'message', success: true);
    // // TESTING =====================
    // final json = await remoteDataSource.analitcLaba(email, token);
    // print(json);
    // print('======================================================');
    // final db = await localDataSource.getPembelian();
    // print(db);
    // print('======================================================');
    // final db2 = await localDataSource.getPenjualan();
    // print(db2);
    // print('======================================================');
    // final db3 = await localDataSource.getBiayaOperasional();
    // print(db3);
    // print('======================================================');
    // return ApiResponse(data: null, message: 'message', success: false);
    // // TESTING =====================
  }

  @override
  Future<ApiResponse<dynamic>> forgotPass(String email) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.forgotPass(email);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse<dynamic>> forgotPassOtp(String email, int otp) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.forgotPassOtp(email, otp);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse;
  }

  @override
  Future<ApiResponse<dynamic>> resetPass(String email, String pass) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.resetPass(email, pass);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse;
  }

  @override
  Future<TokoEntity> getProfile() async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    String email;
    try {
      email = await localDataSource.getEmail();
    } catch (e) {
      throw Exception(e);
    }
    final token = await tokenLocalDataSource.getToken();

    final json = await remoteDataSource.getProfile(email, token!);
    final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
      json,
      (data) => data as Map<String, dynamic>,
    );

    if (!apiResponse.success || apiResponse.data == null) {
      throw Exception(apiResponse.message);
    }

    return TokoModel.fromMap(apiResponse.data!);
  }

  @override
  Future<String> syncAllData() async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    Map<String, dynamic> dataTokoDB;
    String? token;
    try {
      dataTokoDB = await localDataSource.getToko();
      token = await tokenLocalDataSource.getToken();
    } catch (e) {
      throw Exception('Gagal ambil data toko / token: $e');
    }

    if (dataTokoDB.isEmpty || token == null) {
      throw Exception('Gagal ambil data toko dari DB');
    }
    final email = dataTokoDB['email'];
    final alamat = dataTokoDB['alamat'];
    final noTlp = dataTokoDB['no_telp'];
    final namaToko = dataTokoDB['nama_toko'];

    final jsonToko = await remoteDataSource.updateProfile(
      email,
      token,
      alamat,
      noTlp,
      namaToko,
    );
    final apiResponseProfile = ApiResponse<String>.fromJson(
      jsonToko,
      (_) => null,
    );

    if (!apiResponseProfile.success) {
      throw Exception(apiResponseProfile.message);
    }
    String responseAsyc;
    try {
      final results = await Future.wait([
        localDataSource.getBiayaOperasional(),
        localDataSource.getProduct(),
        localDataSource.getHargaProduct(),
        localDataSource.getPembelian(),
        localDataSource.getPenjualan(),
        localDataSource.getProductPerPembelian(),
        localDataSource.getProductPerPenjualan(),
      ]);

      final response = await remoteDataSource.syncAllData(
        email,
        token,
        results[0],
        results[1],
        results[2],
        results[3],
        results[4],
        results[5],
        results[6],
      );
      final apiResponseSync = ApiResponse<String>.fromJson(
        response,
        (data) => data as String,
      );
      if (!apiResponseSync.success) {
        throw Exception(apiResponseSync.message);
      }
      responseAsyc = apiResponseSync.message;
    } catch (e) {
      responseAsyc = 'gagal sinkronisasi ($e)';
    }

    return '${apiResponseProfile.message} dan $responseAsyc';
  }

  // Helper
  Future<void> _syncSingle<TModel>({
    required Future<dynamic> Function() fetch,
    required TModel Function(Map<String, dynamic>) fromMap,
    required Map<String, dynamic> Function(TModel) toMap,
    required Future<void> Function(Map<String, dynamic>) save,
  }) async {
    final raw = await fetch();
    final response = ApiResponse<Map<String, dynamic>>.fromJson(
      raw,
      (data) => data,
    );
    if (!response.success || response.data == null) {
      throw Exception(response.message);
    }
    final model = fromMap(response.data!);
    await save(toMap(model));
  }

  Future<void> _syncList<TModel>({
    required Future<dynamic> Function() fetch,
    required TModel Function(Map<String, dynamic>) fromMap,
    required Map<String, dynamic> Function(TModel) toMap,
    required Future<void> Function(List<Map<String, dynamic>>) saveList,
    String? tableName,
    String? idKey,
  }) async {
    final raw = await fetch();

    final response = ApiResponse<List<Map<String, dynamic>>>.fromJson(
      raw,
      (data) => (data as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    );
    if (!response.success || response.data == null) {
      throw Exception(response.message);
    }
    if (response.data!.isNotEmpty) {
      final maps = response.data!.map(fromMap).map(toMap).toList();
      await saveList(maps);

      if (tableName != null && idKey != null) {
        // reset auto increment to higher than the previos id
        final maxId = response.data!
            .map((e) => e[idKey] as int)
            .reduce((a, b) => a > b ? a : b);
        await localDataSource.resetAutoIncrement(tableName, maxId);
      }
    } else if (tableName != null && idKey != null) {
      // reset auto increment to be 0
      await localDataSource.resetAutoIncrement(tableName, 0);
    }
  }
}
