import 'package:anaytikas_frontend/features/analisis/data/models/analisis_model.dart';

import '../../../config/api/api_helper.dart';

abstract class RemoteDataSource {
  // ACCOUNT
  Future<Map<String, dynamic>> register(String email);
  Future<Map<String, dynamic>> registerOtp(String email, String otp);
  Future<Map<String, dynamic>> registerNewAccount(
    String email,
    String pass,
    String noTlp,
    String alamat,
  );
  Future<Map<String, dynamic>> login(String email, String pass);
  Future<Map<String, dynamic>> logout(String email, String token);
  Future<Map<String, dynamic>> updateProfile(
    String email,
    String token,
    String alamat,
    String noTlp,
  );
  Future<Map<String, dynamic>> getProfile(String email, String token);

  // GET DATA PRODUCT
  Future<Map<String, dynamic>> getProduct(String email, String token);
  Future<Map<String, dynamic>> getHargaProduct(String email, String token);
  Future<Map<String, dynamic>> getBiayaOperasi(String email, String token);
  Future<Map<String, dynamic>> getPembelian(String email, String token);
  Future<Map<String, dynamic>> getPenjualan(String email, String token);
  Future<Map<String, dynamic>> getProductPerPenjualan(
    String email,
    String token,
  );
  Future<Map<String, dynamic>> getProductPerPembelian(
    String email,
    String token,
  );

  // SYNC DATA
  Future<Map<String, dynamic>> syncAllData(
    String email,
    String token,
    List<Map<String, dynamic>> biayaOperasi,
    List<Map<String, dynamic>> product,
    List<Map<String, dynamic>> hargaProduct,
    List<Map<String, dynamic>> pembelian,
    List<Map<String, dynamic>> penjualan,
    List<Map<String, dynamic>> productPerPembelian,
    List<Map<String, dynamic>> productPerPenjualan,
  );

  // ETL
  Future<Map<String, dynamic>> etlBegin(String email, String token);
  Future<AnalisisModel> analitcLaba(String email, String token);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiHelper apiHelper;
  RemoteDataSourceImpl({required this.apiHelper});

  // ACCOUNT
  @override
  Future<Map<String, dynamic>> register(String email) {
    return apiHelper.post('/register', {'email': email});
  }

  @override
  Future<Map<String, dynamic>> registerOtp(String email, String otp) {
    return apiHelper.post('/register/otp', {'email': email, 'otp': otp});
  }

  @override
  Future<Map<String, dynamic>> registerNewAccount(
    String email,
    String pass,
    String noTlp,
    String alamat,
  ) {
    return apiHelper.post('/register/newaccount', {
      'email': email,
      'password': pass,
      'no_telp': noTlp,
      'alamat': alamat,
    });
  }

  @override
  Future<Map<String, dynamic>> login(String email, String pass) {
    return apiHelper.post('/login', {'email': email, 'password': pass});
  }

  @override
  Future<Map<String, dynamic>> logout(String email, String token) {
    return apiHelper.post('/logout', {'email': email, 'token': token});
  }

  @override
  Future<Map<String, dynamic>> updateProfile(
    String email,
    String token,
    String alamat,
    String noTlp,
  ) {
    return apiHelper.post('/update/profile', {
      'email': email,
      'token': token,
      'alamat': alamat,
      'no_telp': noTlp,
    });
  }

  @override
  Future<Map<String, dynamic>> getProfile(String email, String token) {
    return apiHelper.post('/getdata/profile', {'email': email, 'token': token});
  }

  // GET DATA PRODUCT
  @override
  Future<Map<String, dynamic>> getProduct(String email, String token) {
    return apiHelper.post('/getdata/product', {'email': email, 'token': token});
  }

  @override
  Future<Map<String, dynamic>> getHargaProduct(String email, String token) {
    return apiHelper.post('/getdata/harga', {'email': email, 'token': token});
  }

  @override
  Future<Map<String, dynamic>> getBiayaOperasi(String email, String token) {
    return apiHelper.post('/getdata/biayaop', {'email': email, 'token': token});
  }

  @override
  Future<Map<String, dynamic>> getPembelian(String email, String token) {
    return apiHelper.post('/getdata/pembelian', {
      'email': email,
      'token': token,
    });
  }

  @override
  Future<Map<String, dynamic>> getPenjualan(String email, String token) {
    return apiHelper.post('/getdata/penjualan', {
      'email': email,
      'token': token,
    });
  }

  @override
  Future<Map<String, dynamic>> getProductPerPembelian(
    String email,
    String token,
  ) {
    return apiHelper.post('/getdata/productpembelian', {
      'email': email,
      'token': token,
    });
  }

  @override
  Future<Map<String, dynamic>> getProductPerPenjualan(
    String email,
    String token,
  ) {
    return apiHelper.post('/getdata/productpenjualan', {
      'email': email,
      'token': token,
    });
  }

  // SYNC ALL DATA
  @override
  Future<Map<String, dynamic>> syncAllData(
    String email,
    String token,
    List<Map<String, dynamic>> biayaOperasi,
    List<Map<String, dynamic>> product,
    List<Map<String, dynamic>> hargaProduct,
    List<Map<String, dynamic>> pembelian,
    List<Map<String, dynamic>> penjualan,
    List<Map<String, dynamic>> productPerPembelian,
    List<Map<String, dynamic>> productPerPenjualan,
  ) {
    return apiHelper.post('/getdata/productpenjualan', {
      'email': email,
      'token': token,
      'biaya_operasi': biayaOperasi,
      'product': product,
      'harga_product': hargaProduct,
      'pembelian': pembelian,
      'penjualan': penjualan,
      'product_per_pembelian': productPerPembelian,
      'product_per_penjualan': productPerPenjualan,
    });
  }

  // DATA MARKET
  @override
  Future<Map<String, dynamic>> etlBegin(String email, String token) {
    return apiHelper.post('/getdata/productpenjualan', {
      'email': email,
      'token': token,
    });
  }

  @override
  Future<AnalisisModel> analitcLaba(String email, String token) async {
    var data = await apiHelper.post('/wh/laba/latest', {
      'email': email,
      'token': token,
    });
    return AnalisisModel.fromJson(data);
  }
}
