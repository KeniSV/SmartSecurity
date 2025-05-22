import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_smartsecurity/Models/Email.dart';

class EmailService {
  final String baseUrl =
      'http://localhost:8000'; // Cambia esto si usas otro host

  /// Crear un nuevo email/incidente (POST)
  Future<void> crearEmail(Email email) async {
    final url = Uri.parse('$baseUrl/email/');

    final Map<String, dynamic> jsonData = {
      "emailID": email.emailID,
      "subjectEmail": email.subjectEmail,
      "descriptionEmail": email.descriptionEmail,
      "passengerID": email.passengerID,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Email creado exitosamente');
      } else {
        print('❌ Error al crear email: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red al crear email: $e');
    }
  }
}
