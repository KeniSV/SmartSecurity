import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Services/PassengerService.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/PantalladeMiInformaciondeCuentadeUsuario.dart';

class PantalladeActualizarContrasenia extends StatefulWidget {
  final Passenger passenger;
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Email email;

  const PantalladeActualizarContrasenia({
    Key? key,
    required this.passenger,
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.email,
  }) : super(key: key);

  @override
  State<PantalladeActualizarContrasenia> createState() =>
      _PantalladeActualizarContraseniaState();
}

class _PantalladeActualizarContraseniaState
    extends State<PantalladeActualizarContrasenia> {
  final PassengerService passengerService = PassengerService();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  void _guardarNuevaContrasenia() async {
    final currentPassword = currentPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmNewPasswordController.text.trim();

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      _mostrarMensaje("Campo vacío, completa los campos.");
      return;
    }

    if (currentPassword != widget.passenger.passengerpassword) {
      _mostrarMensaje("La contraseña actual no es correcta.");
      return;
    }

    if (newPassword != confirmPassword) {
      _mostrarMensaje("Las contraseñas nuevas no coinciden.");
      return;
    }

    final updatedPassenger = Passenger(
      passengerID: widget.passenger.passengerID,
      passengerfirstName: widget.passenger.passengerfirstName,
      passengerlastname: widget.passenger.passengerlastname,
      passengeremail: widget.passenger.passengeremail,
      passengerdocumentID: widget.passenger.passengerdocumentID,
      passengerdocumentType: widget.passenger.passengerdocumentType,
      passengercellPhone: widget.passenger.passengercellPhone,
      passengercodecellPhone: widget.passenger.passengercodecellPhone,
      passengerpassword: newPassword,
      isActive: widget.passenger.isActive,
    );

    await passengerService.actualizarPassenger(updatedPassenger);

    _mostrarMensaje("Se actualizó satisfactoriamente.");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PantalladeMiInformaciondeCuentadeUsuario(
          driver: widget.driver,
          trustedContact: widget.trustedContact,
          place: widget.place,
          passenger: updatedPassenger,
          email: widget.email,
        ),
      ),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PantalladeMiInformaciondeCuentadeUsuario(
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
            const SizedBox(height: 8),
            const Text("My password",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildInputField(
                "Your current password", currentPasswordController),
            _buildInputField("Enter your new password", newPasswordController),
            _buildInputField(
                "Re-enter your new password", confirmNewPasswordController),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _guardarNuevaContrasenia,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60),
                ),
                child:
                    const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xEEEDE7FE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
