import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheService {
  final Dio dio;

  ImageCacheService(this.dio);

  Future<String> cacheImage(String imageUrl) async {
    log(imageUrl, name: "ImageUrl");
    if (imageUrl.isEmpty || imageUrl.contains('No-Image-Placeholder')) {
      log("No-Image-Placeholder");
      return imageUrl; // Retornamos la URL del placeholder si no hay imagen
    }

    try {
      // Obtén el directorio donde se almacenarán las imágenes
      final directory = await getApplicationDocumentsDirectory();

      // Extrae el nombre del archivo de la URL
      final fileName = imageUrl.split('/').last;
      final localPath = '${directory.path}/movie_images/$fileName';

      // Comprueba si el archivo ya existe en el almacenamiento local
      final imageFile = File(localPath);
      if (await imageFile.exists()) {
        log("existe");
        return localPath; // Devuelve la ruta local si ya está cacheado
      }

      // Crea el directorio de manera recursiva si no existe
      await imageFile.parent.create(recursive: true);

      // Descarga la imagen usando Dio
      final response = await dio.get<List<int>>(
        imageUrl,
        options: Options(
          responseType: ResponseType.bytes, // Descarga como bytes
        ),
      );
      log(response.toString());

      // Guarda los bytes de la imagen en el archivo local
      if (response.statusCode == 200) {
        await imageFile.writeAsBytes(response.data!);
        return localPath;
      }

      return localPath; // Retorna la ruta local de la imagen cacheada
    } catch (e) {
      throw Exception('Failed to cache image: $e');
    }
  }
}
