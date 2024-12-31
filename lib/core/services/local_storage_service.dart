import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;

  LocalStorageService(this._secureStorage, this._sharedPreferences);

  // Métodos para Secure Storage (datos sensibles)
  Future<void> saveSecureData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> deleteSecureData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Métodos para SharedPreferences (datos no sensibles)
  Future<void> saveData(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else {
      // Para objetos complejos, serializar a JSON
      await _sharedPreferences.setString(key, json.encode(value));
    }
  }

  dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  Future<void> removeData(String key) async {
    await _sharedPreferences.remove(key);
  }

  // Guardar y leer objetos serializables
  Future<void> saveObject(String key, dynamic object) async {
    await _sharedPreferences.setString(key, json.encode(object.toJson()));
  }

  dynamic getObject(String key, Function fromJson) {
    final jsonString = _sharedPreferences.getString(key);
    if (jsonString != null) {
      return fromJson(json.decode(jsonString));
    }
    return null;
  }
}
