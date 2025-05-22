import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Services/PlaceService.dart';
import 'package:flutter_smartsecurity/PantalladeMiLugar.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';

class PantalladeAgregarMiLugar extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedcontact;
  final Place place;

  const PantalladeAgregarMiLugar({
    required this.driver,
    required this.trustedcontact,
    required this.place,
    super.key,
  });

  @override
  _PantalladeAgregarMiLugarState createState() =>
      _PantalladeAgregarMiLugarState();
}

class _PantalladeAgregarMiLugarState extends State<PantalladeAgregarMiLugar> {
  final PlaceService placeService = PlaceService();
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    placeNameController.text = widget.place.placeName;
    addressController.text = widget.place.address;
  }

  void agregarLugar() async {
    final nombre = placeNameController.text.trim();
    final direccion = addressController.text.trim();

    if (nombre.isEmpty || direccion.isEmpty) {
      _mostrarAlerta("Please complete all fields.");
      return;
    }

    final nuevoLugar = Place(
      placeID: 0, // Si el backend lo autogenera, este valor se ignora
      placeName: nombre,
      address: direccion,
    );

    try {
      await placeService.crearLugar(nuevoLugar);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PantalladeMiLugar(
            driver: widget.driver,
            trustedcontact: widget.trustedcontact,
            place: nuevoLugar,
          ),
        ),
      );
    } catch (e) {
      _mostrarAlerta("Error while saving: $e");
    }
  }

  void _mostrarAlerta(String mensaje) {
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

  @override
  void dispose() {
    placeNameController.dispose();
    addressController.dispose();
    super.dispose();
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
                builder: (context) => PantalladeMiLugar(
                  driver: widget.driver,
                  trustedcontact: widget.trustedcontact,
                  place: widget.place,
                ),
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My place',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: placeNameController,
              decoration: InputDecoration(
                hintText: 'Name of the place',
                filled: true,
                fillColor: const Color(0xFFEDE7FE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'What is the address?',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFEDE7FE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // TODO: Implementar selección en mapa si se desea
              },
              child: const Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text(
                    'Select on map',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: agregarLugar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
