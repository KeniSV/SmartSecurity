import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_smartsecurity/Models/Driver.dart';

class DriverService {
  final String baseUrl =
      'http://localhost:8000'; // Cambia a tu IP si usas dispositivo físico

  /// Crear un nuevo driver (POST)
  Future<void> crearDriver(Driver driver) async {
    final url = Uri.parse('$baseUrl/driver/');

    final Map<String, dynamic> jsonData = {
      "passenger": {
        "passengerID": driver.passengerID,
        "passengerfirstName": driver.passengerfirstName,
        "passengerlastname": driver.passengerlastname,
        "passengeremail": driver.passengeremail,
        "passengerdocumentID": driver.passengerdocumentID,
        "passengerdocumentType": driver.passengerdocumentType,
        "passengercellPhone": driver.passengercellPhone,
        "passengercodecellPhone": driver.passengercodecellPhone,
        "passengerpassword": driver.passengerpassword,
      },
      "drives": driver.drives,
      "licenseCategory": driver.licenseCategory,
      "licenseNumber": driver.licenseNumber,
      "hasCar": driver.hasCar,
      "licensePlate": driver.licensePlate,
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print('✅ Driver creado exitosamente');
      } else {
        print('❌ Error al crear driver: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  /// Actualizar datos del driver (PUT)
  Future<void> actualizarDriver(Driver driver) async {
    final url = Uri.parse('$baseUrl/driver/${driver.passengerID}');

    final Map<String, dynamic> jsonData = {
      "passenger": {
        "passengerID": driver.passengerID,
        "passengerfirstName": driver.passengerfirstName,
        "passengerlastname": driver.passengerlastname,
        "passengeremail": driver.passengeremail,
        "passengerdocumentID": driver.passengerdocumentID,
        "passengerdocumentType": driver.passengerdocumentType,
        "passengercellPhone": driver.passengercellPhone,
        "passengercodecellPhone": driver.passengercodecellPhone,
        "passengerpassword": driver.passengerpassword,
      },
      "drives": driver.drives,
      "licenseCategory": driver.licenseCategory,
      "licenseNumber": driver.licenseNumber,
      "hasCar": driver.hasCar,
      "licensePlate": driver.licensePlate,
    };

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        print('✅ Driver actualizado exitosamente');
      } else {
        print('❌ Error al actualizar driver: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  /// Eliminar driver (DELETE)
  Future<void> eliminarDriver(int passengerID) async {
    final url = Uri.parse('$baseUrl/driver/$passengerID');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        print('✅ Driver eliminado exitosamente');
      } else {
        print('❌ Error al eliminar driver: ${response.body}');
      }
    } catch (e) {
      print('❗ Error de red: $e');
    }
  }

  Future<bool> obtenerDriverPorID(int id) async {
    final url = Uri.parse('$baseUrl/driver/$id');
    try {
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
