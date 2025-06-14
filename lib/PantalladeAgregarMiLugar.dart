import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_smartsecurity/Services/PlaceService.dart';
import 'package:flutter_smartsecurity/PantalladeMiLugar.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  LatLng? selectedLocation;

  void agregarLugar() async {
    final nombre = placeNameController.text.trim();
    final direccion = addressController.text.trim();

    if (nombre.isEmpty || direccion.isEmpty) {
      _mostrarAlerta("Please complete all fields.");
      return;
    }

    final nuevoLugar = Place(
      placeID: 0,
      placeName: nombre,
      address: direccion,
    );

    try {
      await placeService.crearLugar(nuevoLugar);

      // Mostrar notificacion
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Place added successfully'),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
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
      });
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

  Future<String> obtenerDireccionDesdeCoordenadas(LatLng coordenadas) async {
    final apiKey = 'TU_API_KEY_DE_GOOGLE'; // Reemplaza con tu API KEY
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordenadas.latitude},${coordenadas.longitude}&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        return data['results'][0]['formatted_address'];
      }
    }
    return 'Lat: ${coordenadas.latitude}, Lng: ${coordenadas.longitude}';
  }

  void _seleccionarEnMapa() async {
    LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapaSeleccion(),
      ),
    );
    if (result != null) {
      final direccion = await obtenerDireccionDesdeCoordenadas(result);
      setState(() {
        selectedLocation = result;
        addressController.text = direccion;
      });
    }
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
              onTap: _seleccionarEnMapa,
              child: const Row(
                children: [
                  Icon(Icons.location_on),
                  SizedBox(width: 8),
                  Text(
                    'Select on map',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
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

class MapaSeleccion extends StatefulWidget {
  @override
  State<MapaSeleccion> createState() => _MapaSeleccionState();
}

class _MapaSeleccionState extends State<MapaSeleccion> {
  LatLng _initialPosition = const LatLng(-12.0464, -77.0428);
  LatLng? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Location")),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialPosition, zoom: 14),
        onTap: (pos) => setState(() => _selected = pos),
        markers: _selected != null
            ? {
                Marker(
                  markerId: const MarkerId('selected'),
                  position: _selected!,
                )
              }
            : {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context, _selected),
        child: const Icon(Icons.check),
      ),
    );
  }
}
