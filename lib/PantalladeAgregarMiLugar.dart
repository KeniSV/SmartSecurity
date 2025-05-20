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

  const PantalladeAgregarMiLugar(
      {required this.driver,
      required this.trustedcontact,
      required this.place,
      super.key});

  @override
  _PantalladeAgregarMiLugarState createState() =>
      _PantalladeAgregarMiLugarState();
}

class _PantalladeAgregarMiLugarState extends State<PantalladeAgregarMiLugar> {
  final Placeservice placeService = Placeservice();

  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    placeNameController.text = widget.place.placeName;
    addressController.text = widget.place.address;
  }

  void agregarLugar() {
    final nuevoLugar = Place(
        placeID: DateTime.now().millisecondsSinceEpoch,
        placeName: placeNameController.text,
        address: addressController.text);

    placeService.agregarLugar(nuevoLugar);
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
                      place: widget.place)),
            ); // Acción para retroceder
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Quitar sombra del AppBar
        iconTheme: const IconThemeData(
          color: Colors.black, // Color de la flecha de retroceso
        ),
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
            // Campo de texto para el nombre del lugar
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
            // Campo de texto para la dirección
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
            // Botón para seleccionar en el mapa
            GestureDetector(
              onTap: () {
                // Acción para seleccionar en el mapa
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
            // Botón de Guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60), // Color del botón
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Espaciado interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: agregarLugar, // Acción al presionar el botón "Save"
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
