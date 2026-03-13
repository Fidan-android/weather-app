import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionInfo {
  final Connectivity _connectivity;

  ConnectionInfo(this._connectivity);

  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
