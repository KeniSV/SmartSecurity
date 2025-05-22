import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';

class TrustedContactService {
  final String baseUrl =
      'http://localhost:8000'; // Cambiar a IP real si usas físico o emulador

  /// Crear contacto de confianza (POST)
  Future<void> crearTrustedContact(TrustedContact contacto) async {
    final url = Uri.parse('$baseUrl/trustedcontact/');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(contacto.toJson()),
      );

      if (response.statusCode == 200) {
        print("✅ Contacto creado exitosamente");
      } else {
        print("❌ Error al crear contacto: ${response.body}");
      }
    } catch (e) {
      print("❗ Error de red: $e");
    }
  }

  /// Listar contactos de confianza (GET)
  Future<List<TrustedContact>> listarTrustedContacts() async {
    final url = Uri.parse('$baseUrl/trustedcontact/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => TrustedContact.fromJson(item)).toList();
      } else {
        print("❌ Error al listar contactos: ${response.body}");
        return [];
      }
    } catch (e) {
      print("❗ Error al obtener contactos: $e");
      return [];
    }
  }

  /// Eliminar contacto de confianza (DELETE)
  Future<void> eliminarTrustedContact(int contactID) async {
    final url = Uri.parse('$baseUrl/trustedcontact/$contactID');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print("✅ Contacto eliminado exitosamente");
      } else {
        print("❌ Error al eliminar contacto: ${response.body}");
      }
    } catch (e) {
      print("❗ Error de red: $e");
    }
  }

  /// Buscar contacto de confianza (por nombre o email) - FILTRADO LOCAL
  Future<List<TrustedContact>> buscarTrustedContact(String query) async {
    final lista = await listarTrustedContacts();
    return lista.where((contact) {
      final nombre = contact.trustedContactFullName.toLowerCase();
      final email = contact.trustedContactEmail.toLowerCase();
      final texto = query.toLowerCase();
      return nombre.contains(texto) || email.contains(texto);
    }).toList();
  }
}
