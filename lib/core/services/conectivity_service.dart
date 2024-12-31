import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityService(this._connectivity);

  /// Verifica si el dispositivo está conectado a Internet
  Future<bool> isConnectedToInternet() async {
    try {
      // Obtiene el estado actual de la conectividad
      final List<ConnectivityResult> connectivityResults =
          await _connectivity.checkConnectivity();
      // Verifica si está conectado mediante datos móviles o WiFi
      if (connectivityResults.contains(ConnectivityResult.mobile) ||
          connectivityResults.contains(ConnectivityResult.wifi) ||
          connectivityResults.contains(ConnectivityResult.ethernet)) {
        // Realiza una consulta básica para validar acceso a Internet
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      }
    } catch (e) {
      // Manejo de errores
      log('Error al verificar la conexión: $e');
    }
    return false; // No hay conexión
  }
}
