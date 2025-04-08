import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Services/DriverService.dart';
import 'package:flutter_smartsecurity/PantalladeMiCuentadeUsuario.dart';

class PantalladeMiInformaciondeCuentadeUsuario extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;

  PantalladeMiInformaciondeCuentadeUsuario({
    required this.driver,
    required this.trustedContact,
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  _PantalladeMiInformaciondeCuentadeUsuarioState createState() =>
      _PantalladeMiInformaciondeCuentadeUsuarioState();
}

class _PantalladeMiInformaciondeCuentadeUsuarioState
    extends State<PantalladeMiInformaciondeCuentadeUsuario> {
  final DriverService driverService = DriverService();

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

  @override
  void initState() {
    super.initState();
    // Inicializa los campos con los datos actuales del driver
    firstNameController.text = widget.driver.passengerfirstName;
    lastNameController.text = widget.driver.passengerlastname;
    emailController.text = widget.driver.passengeremail;
    cellPhoneController.text = widget.driver.passengercellPhone.toString();
    documentIDController.text = widget.driver.passengerdocumentID.toString();
    licenseNumberController.text = widget.driver.licenseNumber;
    licensePlateController.text = widget.driver.licensePlate;

    // Verifica que los valores iniciales estén en las listas de opciones
    selectedCode = ['+1', '+51', '+44']
            .contains(widget.driver.passengercodecellPhone.toString())
        ? widget.driver.passengercodecellPhone.toString()
        : null;

    selectedDocumentType =
        ['DNI', 'Passport'].contains(widget.driver.passengerdocumentType)
            ? widget.driver.passengerdocumentType
            : null;

    selectedLicenseCategory =
        ['A', 'B', 'C'].contains(widget.driver.licenseCategory)
            ? widget.driver.licenseCategory
            : null;
  }

  void guardarCambios() {
    driverService.guardarCambiosDatos(
      widget.driver,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      documentID: int.tryParse(documentIDController.text),
      documentType: selectedDocumentType,
      cellPhone: int.tryParse(cellPhoneController.text),
      codeCellPhone: int.tryParse(selectedCode ?? ''),
      drives: widget.driver.drives,
      licenseCategory: selectedLicenseCategory,
      licenseNumber: licenseNumberController.text,
      hasCar: widget.driver.hasCar,
      licensePlate: licensePlateController.text,
    );
    Navigator.pop(context); // Vuelve a la pantalla anterior
  }

  void _eliminarCuenta() {
    driverService.eliminarCuenta(widget.driver);
    Navigator.pop(context); // Vuelve a la pantalla anterior después de eliminar
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
                      )),
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
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last name'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedCode,
                    decoration: const InputDecoration(labelText: 'Code'),
                    items: ['+1', '+51', '+44']
                        .map((code) => DropdownMenuItem<String>(
                              value: code,
                              child: Text(code),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCode = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: cellPhoneController,
                    decoration: const InputDecoration(labelText: 'Cell phone'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedDocumentType,
                    decoration:
                        const InputDecoration(labelText: 'Type of document'),
                    items: ['DNI', 'Passport']
                        .map((docType) => DropdownMenuItem<String>(
                              value: docType,
                              child: Text(docType),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDocumentType = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: documentIDController,
                    decoration: const InputDecoration(labelText: 'ID'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text("Do you drive?"),
              value: widget.driver.drives,
              onChanged: (bool? value) {
                setState(() {
                  widget.driver.drives = value ?? false;
                });
              },
            ),
            if (widget.driver.drives)
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedLicenseCategory,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: ['A', 'B', 'C']
                          .map((category) => DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLicenseCategory = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: licenseNumberController,
                      decoration:
                          const InputDecoration(labelText: 'N° License'),
                    ),
                  ),
                ],
              ),
            CheckboxListTile(
              title: const Text("Do you have a car?"),
              value: widget.driver.hasCar,
              onChanged: (bool? value) {
                setState(() {
                  widget.driver.hasCar = value ?? false;
                });
              },
            ),
            if (widget.driver.hasCar)
              TextField(
                controller: licensePlateController,
                decoration:
                    const InputDecoration(labelText: 'N° License plate'),
              ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                // Acción de cambiar contraseña
              },
              child: const Text("Change password",
                  style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                // Acción de cerrar sesión
              },
              child: const Text("Log out", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: _eliminarCuenta,
              child: Text("Delete account",
                  style: TextStyle(color: Colors.red.shade800)),
            ),
          ],
        ),
      ),
    );
  }
}
