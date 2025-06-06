import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_smartsecurity/Models/Keyword.dart';

class KeywordService {
  final String baseUrl =
      'http://localhost:8000'; // Cambia por tu IP si usas emulador físico

  /// Crear palabra clave (POST)
  Future<void> crearKeyword(Keyword keyword) async {
    final url = Uri.parse('$baseUrl/keyword/');

    // Solo incluir keywordName al crear
    final body = {
      "keywordName": keyword.keywordName,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Palabra clave creada exitosamente");
      } else {
        print("❌ Error al crear palabra clave: ${response.body}");
        throw Exception("Error al crear palabra clave");
      }
    } catch (e) {
      print("❗ Error de red al crear palabra clave: $e");
      throw Exception("Error de red al crear palabra clave");
    }
  }

  /// Listar palabras clave (GET)
  Future<List<Keyword>> listarKeywords() async {
    final url = Uri.parse('$baseUrl/keyword/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Keyword.fromJson(item)).toList();
      } else {
        print("❌ Error al listar palabras clave: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❗ Error de red al listar palabras clave: $e");
      return [];
    }
  }

  /// Eliminar palabra clave (DELETE)
  Future<void> eliminarKeyword(int keywordID) async {
    final url = Uri.parse('$baseUrl/keyword/$keywordID');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print("✅ Palabra clave eliminada exitosamente");
      } else {
        print("❌ Error al eliminar palabra clave: ${response.body}");
        throw Exception("Error al eliminar palabra clave");
      }
    } catch (e) {
      print("❗ Error de red al eliminar palabra clave: $e");
      throw Exception("Error de red al eliminar palabra clave");
    }
  }

  /// Actualizar palabra clave (PUT)
  Future<void> actualizarKeyword(Keyword keyword) async {
    final url = Uri.parse('$baseUrl/keyword/${keyword.keywordID}');
    final body = {
      "keywordID": keyword.keywordID,
      "keywordName": keyword.keywordName,
    };

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("✅ Palabra clave actualizada exitosamente");
      } else {
        print("❌ Error al actualizar palabra clave: ${response.body}");
        throw Exception("Error al actualizar palabra clave");
      }
    } catch (e) {
      print("❗ Error de red al actualizar palabra clave: $e");
      throw Exception("Error de red al actualizar palabra clave");
    }
  }
}
