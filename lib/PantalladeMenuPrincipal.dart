import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Services/PlaceService.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PantalladeMenuPrincipal extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedContact;
  final Place place;
  final Passenger passenger;
  final Email email;

  const PantalladeMenuPrincipal({
    required this.driver,
    required this.trustedContact,
    required this.place,
    required this.passenger,
    required this.email,
    super.key,
  });

  @override
  State<PantalladeMenuPrincipal> createState() =>
      _PantalladeMenuPrincipalState();
}

class _PantalladeMenuPrincipalState extends State<PantalladeMenuPrincipal> {
  bool isVoiceRecognitionActive = false;
  late GoogleMapController mapController;
  LatLng _currentLocation =
      const LatLng(-12.0464, -77.0428); // Lima por defecto

  final TextEditingController routeController = TextEditingController();
  final PlaceService placeService = PlaceService();
  List<Place> lugares = [];

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
    _cargarLugares();
  }

  Future<void> _obtenerUbicacion() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) serviceEnabled = await location.requestService();
    if (!serviceEnabled) return;

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final userLocation = await location.getLocation();
    setState(() {
      _currentLocation =
          LatLng(userLocation.latitude!, userLocation.longitude!);
    });
  }

  Future<void> _cargarLugares() async {
    final lista = await placeService.listarLugares();
    setState(() => lugares = lista);
  }

  Future<void> _buscarLugares(String query) async {
    if (query.trim().isEmpty) {
      _cargarLugares();
    } else {
      final resultados = await placeService.buscarLugar(query);
      setState(() => lugares = resultados);
    }
  }

  void _seleccionarLugar(Place lugar) {
    setState(() {
      routeController.text = lugar.address;
      lugares = []; // Oculta sugerencias tras seleccionar
    });
  }

  void enviarMensajeDeAyudaWhatsApp() async {
    const numero = '51994702577';
    final mensaje = Uri.encodeComponent(
        '¡Necesito ayuda! Por favor, contáctame lo antes posible.');
    final url = 'https://wa.me/$numero?text=$mensaje';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  void enviarMensajeDeAyudaSMS() async {
    const numero = '51994702577';
    final mensaje = Uri.encodeComponent(
        '¡Necesito ayuda! Por favor, contáctame lo antes posible.');
    final url = 'sms:$numero?body=$mensaje';

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'No se pudo enviar el SMS';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Mapa
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  onMapCreated: (controller) => mapController = controller,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PantalladeUsuario(
                              driver: widget.driver,
                              trustedContact: widget.trustedContact,
                              place: widget.place,
                              passenger: widget.passenger,
                              email: widget.email,
                            ),
                          ),
                        );
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Contenido
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  const Text('¡Hi, User!',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Are you safe?',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        enviarMensajeDeAyudaWhatsApp();
                        enviarMensajeDeAyudaSMS();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(50),
                        backgroundColor: Colors.blueAccent,
                        elevation: 10,
                      ),
                      child: const Text('HELP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Switch(
                        value: isVoiceRecognitionActive,
                        onChanged: (value) =>
                            setState(() => isVoiceRecognitionActive = value),
                        activeColor: Colors.indigo,
                      ),
                      const Text('Activate voice recognition'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: routeController,
                    onChanged: _buscarLugares,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Enter your route',
                      filled: true,
                      fillColor: Colors.purple[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (lugares.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: lugares.map((place) {
                        return ListTile(
                          leading: const Icon(Icons.location_on,
                              color: Colors.indigo),
                          title: Text(place.placeName),
                          subtitle: Text(place.address),
                          onTap: () => _seleccionarLugar(place),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => PantalladeSoporte(
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Service'),
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Support'),
        ],
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
