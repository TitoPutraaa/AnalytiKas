import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiHelper {
  final http.Client client;
  final String baseUrl;

  ApiHelper({required this.client, required this.baseUrl});

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final respone = await client
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 30));

      if (respone.statusCode != 200) {
        print("DEBUG: Status Code: ${respone.statusCode}");
        print("DEBUG: Response Body: ${respone.body}");
      }
      final json = jsonDecode(respone.body) as Map<String, dynamic>;
      if (respone.statusCode == 200 || respone.statusCode == 201) {
        return json;
      } else {
        throw Exception(
          json['message'] ?? 'Request failed (${respone.statusCode})',
        );
      }
    } on TimeoutException {
      throw Exception('Koneksi timeout, coba lagi');
    } on SocketException {
      throw Exception('Tidak ada koneksi internet');
    }
  }
}
