import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_smartsecurity/Models/Place.dart';

class PlaceService {
  final String baseUrl =
      'http://localhost:8000'; // Cambia si usas emulador físico

  /// Crear lugar (POST)
  Future<void> crearLugar(Place lugar) async {
    final url = Uri.parse('$baseUrl/place/');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(lugar.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ Lugar creado exitosamente");
      } else {
        print("❌ Error al crear lugar: ${response.body}");
      }
    } catch (e) {
      print("❗ Error de red: $e");
    }
  }

  /// Listar lugares (GET)
  Future<List<Place>> listarLugares() async {
    final url = Uri.parse('$baseUrl/place/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Place.fromJson(item)).toList();
      } else {
        print("❌ Error al listar lugares: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❗ Error al obtener lugares: $e");
      return [];
    }
  }

  /// Buscar lugares por nombre o dirección (GET /place/search/)
  Future<List<Place>> buscarLugar(String query) async {
    final url = Uri.parse('$baseUrl/place/search/?query=$query');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Place.fromJson(item)).toList();
      } else {
        print("❌ Error al buscar lugar: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❗ Error de red al buscar lugar: $e");
      return [];
    }
  }

  /// Eliminar lugar (DELETE)
  Future<void> eliminarLugar(int placeID) async {
    final url = Uri.parse('$baseUrl/place/$placeID');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print("✅ Lugar eliminado exitosamente");
      } else {
        print("❌ Error al eliminar lugar: ${response.body}");
      }
    } catch (e) {
      print("❗ Error de red: $e");
    }
  }
}
