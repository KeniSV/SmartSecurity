import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Services/DriverService.dart';
import 'package:flutter_smartsecurity/Services/PassengerService.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeInicio.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

class PantalladeMiInformaciondeCuentadeUsuario extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeMiInformaciondeCuentadeUsuario({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  _PantalladeMiInformaciondeCuentadeUsuarioState createState() =>
      _PantalladeMiInformaciondeCuentadeUsuarioState();
}

class _PantalladeMiInformaciondeCuentadeUsuarioState
    extends State<PantalladeMiInformaciondeCuentadeUsuario> {
  final DriverService driverService = DriverService();
  final PassengerService passengerService = PassengerService();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cellPhoneController = TextEditingController();
  final TextEditingController documentIDController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController licensePlateController = TextEditingController();

  String? selectedCode;
  String? selectedDocumentType;
  String? selectedLicenseCategory;
  bool isDriver = false;

  final List<String> codigosDisponibles = ['+1', '+51', '+44'];

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.driver.passengerfirstName;
    lastNameController.text = widget.driver.passengerlastname;
    emailController.text = widget.driver.passengeremail;
    cellPhoneController.text = widget.driver.passengercellPhone.toString();
    documentIDController.text = widget.driver.passengerdocumentID.toString();
    licenseNumberController.text = widget.driver.licenseNumber;
    licensePlateController.text = widget.driver.licensePlate;

    final codigo = '+${widget.driver.passengercodecellPhone}';
    selectedCode = codigosDisponibles.contains(codigo) ? codigo : null;

    selectedDocumentType = widget.driver.passengerdocumentType;
    selectedLicenseCategory = widget.driver.licenseCategory;

    isDriver = widget.driver.drives;
  }

  Future<void> guardarCambios() async {
    final updatedPassenger = Passenger(
      passengerID: widget.driver.passengerID,
      passengerfirstName: firstNameController.text,
      passengerlastname: lastNameController.text,
      passengeremail: emailController.text,
      passengerdocumentID: int.tryParse(documentIDController.text) ?? 0,
      passengerdocumentType: selectedDocumentType ?? 'DNI',
      passengercellPhone: int.tryParse(cellPhoneController.text) ?? 0,
      passengercodecellPhone:
          int.tryParse(selectedCode?.replaceAll('+', '') ?? '51') ?? 51,
      passengerpassword: widget.driver.passengerpassword,
    );

    if (isDriver) {
      final updatedDriver = Driver(
        passengerID: updatedPassenger.passengerID,
        passengerfirstName: updatedPassenger.passengerfirstName,
        passengerlastname: updatedPassenger.passengerlastname,
        passengeremail: updatedPassenger.passengeremail,
        passengerdocumentID: updatedPassenger.passengerdocumentID,
        passengerdocumentType: updatedPassenger.passengerdocumentType,
        passengercellPhone: updatedPassenger.passengercellPhone,
        passengercodecellPhone: updatedPassenger.passengercodecellPhone,
        passengerpassword: updatedPassenger.passengerpassword,
        drives: true,
        licenseCategory: selectedLicenseCategory ?? '',
        licenseNumber: licenseNumberController.text,
        hasCar: widget.driver.hasCar,
        licensePlate: licensePlateController.text,
      );
      await driverService.actualizarDriver(updatedDriver);
    } else {
      await passengerService.actualizarPassenger(updatedPassenger);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Information updated successfully')),
    );

    Navigator.pop(context);
  }

  Future<void> _eliminarCuenta() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning', style: TextStyle(color: Colors.red)),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                if (isDriver) {
                  await driverService.eliminarDriver(widget.driver.passengerID);
                } else {
                  await passengerService
                      .eliminarPassenger(widget.driver.passengerID);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account deleted successfully')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeInicio(
                      passenger: widget.passenger,
                      driver: widget.driver,
                      trustedContact: widget.trustedContact,
                      place: widget.place,
                      email: widget.email,
                    ),
                  ),
                );
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PantalladeMiCuentadeUsuario(
                  driver: widget.driver,
                  trustedContact: widget.trustedContact,
                  place: widget.place,
                  passenger: widget.passenger,
                  email: widget.email,
                ),
              ),
            );
          },
        ),
        title: const Text("My data"),
        actions: [
          TextButton(
            onPressed: guardarCambios,
            child: const Text("Save", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade200,
                child:
                    const Icon(Icons.camera_alt, size: 40, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text("All your personal information",
                  style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 24),
            _buildTextField(firstNameController, 'First name'),
            _buildTextField(lastNameController, 'Last name'),
            _buildDropdownWithTextField(
                'Code', codigosDisponibles, selectedCode, (val) {
              setState(() => selectedCode = val);
            }, cellPhoneController, 'Cell phone'),
            _buildDropdownWithTextField(
                'Type of document', ['DNI', 'Passport'], selectedDocumentType,
                (val) {
              setState(() => selectedDocumentType = val);
            }, documentIDController, 'ID'),
            _buildTextField(
                emailController, 'Email', TextInputType.emailAddress),
            CheckboxListTile(
              title: const Text("Do you drive?"),
              value: isDriver,
              onChanged: (bool? value) {
                setState(() => isDriver = value ?? false);
              },
            ),
            if (isDriver)
              _buildDropdownWithTextField(
                  'Category', ['A', 'B', 'C'], selectedLicenseCategory, (val) {
                setState(() => selectedLicenseCategory = val);
              }, licenseNumberController, 'N° License'),
            if (isDriver)
              CheckboxListTile(
                title: const Text("Do you have a car?"),
                value: widget.driver.hasCar,
                onChanged: (bool? value) {
                  setState(() => widget.driver.hasCar = value ?? false);
                },
              ),
            if (isDriver && widget.driver.hasCar)
              _buildTextField(licensePlateController, 'N° License plate'),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {},
              child: const Text("Change password",
                  style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Log out", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: _eliminarCuenta,
              child: const Text("Delete account",
                  style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType inputType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        keyboardType: inputType,
      ),
    );
  }

  Widget _buildDropdownWithTextField(
    String dropdownLabel,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
    TextEditingController controller,
    String fieldLabel,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: items.contains(selectedValue) ? selectedValue : null,
              decoration: InputDecoration(labelText: dropdownLabel),
              items: items
                  .map((item) =>
                      DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(labelText: fieldLabel),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
