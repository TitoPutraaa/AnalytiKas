import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isOnline() async {
    final List<ConnectivityResult> results = await _connectivity
        .checkConnectivity();

    return !results.contains(ConnectivityResult.none);
  }
}
