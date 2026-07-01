import 'package:anaytikas_frontend/core/shared/data/datasources/local_data_source.dart';
import 'package:anaytikas_frontend/core/shared/data/datasources/token_local_data_source.dart';
import 'package:anaytikas_frontend/core/shared/entities/toko_entity.dart';
import 'package:anaytikas_frontend/core/shared/models/biaya_opr_model.dart';
import 'package:anaytikas_frontend/core/shared/models/harga_model.dart';
import 'package:anaytikas_frontend/core/shared/models/penjualan_model.dart';
import 'package:anaytikas_frontend/core/shared/models/product_model.dart';
import 'package:anaytikas_frontend/core/shared/models/product_per_pembelian_model.dart';
import 'package:anaytikas_frontend/core/shared/models/product_per_penjualan_model.dart';
import 'package:anaytikas_frontend/core/shared/models/toko_model.dart';
import 'package:anaytikas_frontend/features/stok/data/models/pembelian_model.dart';

import '../../../config/network/connectivity_helper.dart';
import '../../domain/repositories/account_repository.dart';
import '../../models/api_response.dart';
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
  Future<String> register(String email) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.register(email);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse.message;
  }

  @override
  Future<String> registerOtp(String email, int otp) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    final json = await remoteDataSource.registerOtp(email, otp);
    final apiResponse = ApiResponse.fromJson(json, (_) => null);

    if (!apiResponse.success) {
      throw Exception(apiResponse.message);
    }
    return apiResponse.message;
  }

  @override
  Future<String> registerNewAccount(
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

    return apiResponse.message;
  }

  @override
  Future<String> login(String email, String pass) async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }
    bool syncFailed = false;

    final json = await remoteDataSource.login(email, pass);
    final apiResponse = ApiResponse<String>.fromJson(
      json,
      (data) => data as String,
    );

    if (!apiResponse.success || apiResponse.data == null) {
      throw Exception(apiResponse.message);
    }
    final String token = apiResponse.data!;
    await tokenLocalDataSource.saveToken(token);

    // Ambil seluruh data dan simpan di db jika ada
    try {
      await Future.wait([
        _syncSingle(
          fetch: () => remoteDataSource.getProfile(email, token),
          fromMap: TokoModel.fromMap,
          toMap: (model) => model.toMap(),
          save: localDataSource.saveToko,
        ).catchError((e) {
          print('Gagal sync profile: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getProduct(email, token),
          fromMap: ProductModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.saveProducts,
        ).catchError((e) {
          print('Gagal sync product: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getHargaProduct(email, token),
          fromMap: HargaModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.saveHargaProducts,
        ).catchError((e) {
          print('Gagal sync harga: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getBiayaOperasi(email, token),
          fromMap: BiayaOprModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.saveBiayaOp,
        ).catchError((e) {
          print('Gagal sync biayaOp: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getPembelian(email, token),
          fromMap: PembelianModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.savePembelian,
        ).catchError((e) {
          print('Gagal sync pembelian: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getPenjualan(email, token),
          fromMap: PenjualanModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.savePenjualan,
        ).catchError((e) {
          print('Gagal sync penjualan: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getProductPerPembelian(email, token),
          fromMap: ProductPerPembelianModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.saveProductPerPemb,
        ).catchError((e) {
          print('Gagal sync proPerpemb: $e');
          return null;
        }),
        _syncList(
          fetch: () => remoteDataSource.getProductPerPenjualan(email, token),
          fromMap: ProductPerPenjualanModel.fromMap,
          toMap: (model) => model.toMap(),
          saveList: localDataSource.saveProductPerPenj,
        ).catchError((e) {
          print('Gagal sync proPerpenj: $e');
          return null;
        }),
      ], eagerError: false);
    } catch (e) {
      syncFailed = true;
    }
    if (syncFailed) {
      return '${apiResponse.message} (peringatan: sebagian data gagal disinkronkan)';
    }
    return apiResponse.message;
  }

  @override
  Future<String> logout() async {
    if (!await connectivityHelper.isOnline()) {
      throw Exception('Tidak ada koneksi internet');
    }

    String email;
    String? token;
    try {
      email = await localDataSource.getEmail();
      token = await tokenLocalDataSource.getToken();
    } catch (e) {
      throw Exception('Gagal ambil data toko / token: $e');
    }

    if (email.isEmpty || token == null) {
      throw Exception('Gagal ambil data toko dari DB');
    }
    await syncAllData();

    final json = await remoteDataSource.logout(email, token);
    final apiResponse = ApiResponse<String>.fromJson(
      json,
      (data) => data as String,
    );

    // hapus data
    try {
      await localDataSource.clearAllTables();
      await tokenLocalDataSource.deleteToken();
    } catch (e) {
      throw Exception(e);
    }
    return apiResponse.message;
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
      (data) => data as String,
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
  }) async {
    final raw = await fetch();
    final response = ApiResponse<List<Map<String, dynamic>>>.fromJson(
      raw,
      (data) => data,
    );
    if (!response.success || response.data == null) {
      throw Exception(response.message);
    }
    if (response.data!.isNotEmpty) {
      final maps = response.data!.map(fromMap).map(toMap).toList();
      await saveList(maps);
    }
  }
}
