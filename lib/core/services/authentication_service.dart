import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/network/dio_client.dart';

class AuthenticationService {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage;

  AuthenticationService(this._dioClient, this._secureStorage);

  // Iniciar sesión
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      // Guardar token de forma segura
      await _secureStorage.write(key: 'auth_token', value: response['token']);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Registro de usuario
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _dioClient.post(
        '/register',
        data: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    try {
      // Llamada opcional al backend para invalidar token
      await _dioClient.post('/logout');

      // Limpiar token almacenado
      await _secureStorage.delete(key: 'auth_token');
    } catch (e) {
      rethrow;
    }
  }

  // Verificar si el usuario está autenticado
  Future<bool> isAuthenticated() async {
    final token = await _secureStorage.read(key: 'auth_token');
    return token != null;
  }

  // Obtener token almacenado
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }
}
