import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/PantalladeRegistrodeUsuario.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

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
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool acceptTerms = false;

  @override
  void initState() {
    super.initState();
    emailController =
        TextEditingController(text: widget.passenger.passengeremail);
    phoneController = TextEditingController(
        text: widget.passenger.passengercellPhone.toString());
    passwordController =
        TextEditingController(text: widget.passenger.passengerpassword);
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0CCFF),
              Color(0xFF2C2E8D),
            ],
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
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
                            onChanged: (value) {
                              setState(() {
                                acceptTerms = value!;
                              });
                            },
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
                          onPressed: () {
                            // Acción Sign in → regresar a PantalladeRegistrodeUsuario
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PantalladeRegistrodeUsuario(
                                  passenger: widget.passenger,
                                  driver: widget.driver,
                                  trustedContact: widget.trustedContact,
                                  place: widget.place,
                                  email: widget.email,
                                ),
                              ),
                            );
                          },
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
}
