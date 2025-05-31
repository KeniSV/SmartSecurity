import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_smartsecurity/Models/Passenger.dart';

class PassengerService {
  final String baseUrl =
      'http://localhost:8000'; // Cambia si usas dispositivo físico

  /// Crear nuevo pasajero (POST)
  Future<void> crearPassenger(Passenger passenger) async {
    final url = Uri.parse('$baseUrl/passenger/');

    final Map<String, dynamic> jsonData = {
      "passengerfirstName": passenger.passengerfirstName,
      "passengerlastname": passenger.passengerlastname,
      "passengeremail": passenger.passengeremail,
      "passengerdocumentID": passenger.passengerdocumentID,
      "passengerdocumentType": passenger.passengerdocumentType,
      "passengercellPhone": passenger.passengercellPhone,
      "passengercodecellPhone": passenger.passengercodecellPhone,
      "passengerpassword": passenger.passengerpassword,
      "isActive": passenger.isActive,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Passenger creado exitosamente');
      } else {
        print('❌ Error al crear passenger: ${response.statusCode}');
        print('🧾 Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  /// Actualizar pasajero (PUT)
  Future<void> actualizarPassenger(Passenger passenger) async {
    final url = Uri.parse('$baseUrl/passenger/${passenger.passengerID}');

    final Map<String, dynamic> jsonData = {
      "passengerfirstName": passenger.passengerfirstName,
      "passengerlastname": passenger.passengerlastname,
      "passengeremail": passenger.passengeremail,
      "passengerdocumentID": passenger.passengerdocumentID,
      "passengerdocumentType": passenger.passengerdocumentType,
      "passengercellPhone": passenger.passengercellPhone,
      "passengercodecellPhone": passenger.passengercodecellPhone,
      "passengerpassword": passenger.passengerpassword,
      "isActive": passenger.isActive,
    };

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print('✅ Passenger actualizado exitosamente');
      } else {
        print('❌ Error al actualizar passenger: ${response.statusCode}');
        print('🧾 Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  /// Eliminar pasajero (DELETE)
  Future<void> eliminarPassenger(int passengerID) async {
    final url = Uri.parse('$baseUrl/passenger/$passengerID');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('✅ Passenger eliminado exitosamente');
      } else {
        print('❌ Error al eliminar passenger: ${response.statusCode}');
        print('🧾 Respuesta del servidor: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  /// Login por email y contraseña
  Future<Passenger?> buscarPassengerPorEmailYPassword(
      String email, String password) async {
    final url = Uri.parse('$baseUrl/login/');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Passenger.fromJson(data);
      } else {
        print("❌ Login fallido: ${response.statusCode}");
        print("🧾 Respuesta del servidor: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❗ Error al autenticar: $e");
      return null;
    }
  }
}
