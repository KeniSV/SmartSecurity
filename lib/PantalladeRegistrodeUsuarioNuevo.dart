import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/PantalladeRegistrodeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Services/PassengerService.dart';

class PantalladeRegistrodeUsuarioNuevo extends StatefulWidget {
  final Passenger passenger;
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Email email;

  const PantalladeRegistrodeUsuarioNuevo({
    Key? key,
    required this.passenger,
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.email,
  }) : super(key: key);

  @override
  _PantalladeRegistrodeUsuarioNuevoState createState() =>
      _PantalladeRegistrodeUsuarioNuevoState();
}

class _PantalladeRegistrodeUsuarioNuevoState
    extends State<PantalladeRegistrodeUsuarioNuevo> {
  final PassengerService passengerService = PassengerService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool acceptTerms = false;

  void _registrarPasajero() async {
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      _mostrarDialogo("Please fill in all fields.");
      return;
    }

    if (password != confirmPassword) {
      _mostrarDialogo("Passwords do not match.");
      return;
    }

    if (!acceptTerms) {
      _mostrarDialogo("You must accept the terms to continue.");
      return;
    }

    try {
      final nuevoPasajero = Passenger(
        passengerID: DateTime.now().millisecondsSinceEpoch,
        passengerfirstName: '',
        passengerlastname: '',
        passengeremail: email,
        passengerdocumentID: 0,
        passengerdocumentType: '',
        passengercellPhone: int.tryParse(phone) ?? 0,
        passengercodecellPhone: 0,
        passengerpassword: password,
      );

      await passengerService.crearPassenger(nuevoPasajero);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => PantalladeRegistrodeUsuario(
            passenger: nuevoPasajero,
            driver: widget.driver,
            trustedContact: widget.trustedContact,
            place: widget.place,
            email: widget.email,
          ),
        ),
      );
    } catch (e) {
      _mostrarDialogo("Error while registering: $e");
    }
  }

  void _mostrarDialogo(String mensaje) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE0CCFF), Color(0xFF2C2E8D)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.indigo),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantalladeRegistrodeUsuario(
                          passenger: widget.passenger,
                          driver: widget.driver,
                          trustedContact: widget.trustedContact,
                          place: widget.place,
                          email: widget.email,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Please enter your personal info',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField('Enter your email', emailController),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Enter your phone number', phoneController),
                      const SizedBox(height: 16),
                      _buildTextField('Enter the password', passwordController,
                          isPassword: true),
                      const SizedBox(height: 16),
                      _buildTextField(
                          'Re enter the password', confirmPasswordController,
                          isPassword: true),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: acceptTerms,
                            onChanged: (value) =>
                                setState(() => acceptTerms = value ?? false),
                            activeColor: Colors.indigo,
                          ),
                          const Expanded(
                            child: Text(
                              'I accept the terms of the agreement',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: acceptTerms ? _registrarPasajero : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo[900],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
