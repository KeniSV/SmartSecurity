import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeMenuPrincipal.dart';
import 'package:flutter_smartsecurity/PantalladeInicio.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';

class PantalladeRegistrodeUsuario extends StatefulWidget {
  final Passenger passenger;
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Email email;

  const PantalladeRegistrodeUsuario({
    Key? key,
    required this.passenger,
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.email,
  }) : super(key: key);

  @override
  _PantalladeRegistrodeUsuarioState createState() =>
      _PantalladeRegistrodeUsuarioState();
}

class _PantalladeRegistrodeUsuarioState
    extends State<PantalladeRegistrodeUsuario> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _validarCredenciales() {
    final emailIngresado = emailController.text.trim();
    final passwordIngresado = passwordController.text.trim();

    if (emailIngresado == widget.passenger.passengeremail &&
        passwordIngresado == widget.passenger.passengerpassword) {
      bool captchaChecked = false;

      showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text(
              'Confirm Login',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
            content: Row(
              children: [
                Checkbox(
                  value: captchaChecked,
                  onChanged: (value) {
                    setState(() {
                      captchaChecked = value!;
                    });
                  },
                ),
                const Text("I'm not a robot"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (captchaChecked) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PantalladeMenuPrincipal(
                          driver: widget.driver,
                          trustedContact: widget.trustedContact,
                          place: widget.place,
                          passenger: widget.passenger,
                          email: widget.email,
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Invalid email or password.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
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
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter the password',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) =>
                                setState(() => rememberMe = value ?? false),
                            activeColor: Colors.indigo,
                          ),
                          const Text('Remember me',
                              style: TextStyle(color: Colors.white)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Acción "Forgot password"
                            },
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _validarCredenciales,
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
