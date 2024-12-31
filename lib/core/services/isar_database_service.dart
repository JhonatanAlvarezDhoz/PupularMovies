import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabaseService {
  static final Map<String, Isar> _instances = {};

  /// Obtiene una instancia de Isar para un conjunto de esquemas específico
  static Future<Isar> getInstance(
      String instanceName, List<CollectionSchema> schemas) async {
    if (_instances.containsKey(instanceName)) {
      return _instances[instanceName]!;
    }

    final directory = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      schemas,
      directory: directory.path,
      name: instanceName,
      inspector: true,
    );
    _instances[instanceName] = isar;
    return isar;
  }

  /// Cierra todas las instancias abiertas (opcional)
  static Future<void> closeAllInstances() async {
    for (final isar in _instances.values) {
      if (isar.isOpen) {
        await isar.close();
      }
    }
    _instances.clear();
  }
}
