import 'package:flutter_smartsecurity/Models/Driver.dart';

class DriverService {
  final List<Driver> _drivers = [];

  void guardarCambiosDatos(
    Driver driver, {
    String? firstName,
    String? lastName,
    String? email,
    int? documentID,
    String? documentType,
    int? cellPhone,
    int? codeCellPhone,
    bool? drives,
    String? licenseCategory,
    String? licenseNumber,
    bool? hasCar,
    String? licensePlate,
  }) {
    try {
      if (firstName != null) driver.passengerfirstName = firstName;
      if (lastName != null) driver.passengerlastname = lastName;
      if (email != null) driver.passengeremail = email;
      if (documentID != null) driver.passengerdocumentID = documentID;
      if (documentType != null) driver.passengerdocumentType = documentType;
      if (cellPhone != null) driver.passengercellPhone = cellPhone;
      if (codeCellPhone != null) driver.passengercodecellPhone = codeCellPhone;
      if (drives != null) driver.drives = drives;
      if (licenseCategory != null) driver.licenseCategory = licenseCategory;
      if (licenseNumber != null) driver.licenseNumber = licenseNumber;
      if (hasCar != null) driver.hasCar = hasCar;
      if (licensePlate != null) driver.licensePlate = licensePlate;
      print(
          "Datos del conductor '${driver.passengerfirstName}' actualizados exitosamente.");
    } catch (e) {
      print("Error al actualizar datos del conductor: $e");
    }
  }

  void eliminarCuenta(Driver driver) {
    try {
      _drivers.removeWhere((d) => d.passengerID == driver.passengerID);
      print("Cuenta de '${driver.passengerfirstName}' eliminada exitosamente.");
    } catch (e) {
      print("Error al eliminar la cuenta: $e");
    }
  }
}
