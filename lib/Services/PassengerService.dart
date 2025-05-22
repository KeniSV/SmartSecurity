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
      "passengerID": passenger.passengerID,
      "passengerFirstName": passenger.passengerfirstName,
      "passengerLastName": passenger.passengerlastname,
      "passengerEmail": passenger.passengeremail,
      "passengerDocumentID": passenger.passengerdocumentID,
      "passengerDocumentType": int.tryParse(passenger.passengerdocumentType),
      "passengerCellPhone": passenger.passengercellPhone,
      "passengerCodeCellPhone": passenger.passengercodecellPhone,
      "passengerPassword": passenger.passengerpassword,
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
        print('❌ Error al crear passenger: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  /// Actualizar pasajero (PUT)
  Future<void> actualizarPassenger(Passenger passenger) async {
    final url = Uri.parse('$baseUrl/passenger/${passenger.passengerID}');

    final Map<String, dynamic> jsonData = {
      "passengerID": passenger.passengerID,
      "passengerFirstName": passenger.passengerfirstName,
      "passengerLastName": passenger.passengerlastname,
      "passengerEmail": passenger.passengeremail,
      "passengerDocumentID": passenger.passengerdocumentID,
      "passengerDocumentType": int.tryParse(passenger.passengerdocumentType),
      "passengerCellPhone": passenger.passengercellPhone,
      "passengerCodeCellPhone": passenger.passengercodecellPhone,
      "passengerPassword": passenger.passengerpassword,
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
        print('❌ Error al actualizar passenger: ${response.body}');
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
        print('❌ Error al eliminar passenger: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }
}
