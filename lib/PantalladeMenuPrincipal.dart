import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeUsuario.dart';
import 'package:flutter_smartsecurity/PantalladeSoporte.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Models/Passenger.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/Email.dart';
import 'package:flutter_smartsecurity/Services/PlaceService.dart';
import 'package:flutter_smartsecurity/Services/TrustedContactService.dart';
import 'package:flutter_smartsecurity/Services/KeywordService.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
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
  LatLng _currentLocation = const LatLng(-12.0464, -77.0428);

  final TextEditingController routeController = TextEditingController();
  final PlaceService placeService = PlaceService();
  final TrustedContactService _trustedContactService = TrustedContactService();
  final KeywordService _keywordService = KeywordService();
  List<Place> lugares = [];

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
    _cargarLugares();
  }

  Future<void> _obtenerUbicacion() async {
    Location location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) return;
    }
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }

    final loc = await location.getLocation();
    setState(() => _currentLocation = LatLng(loc.latitude!, loc.longitude!));
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
      lugares = [];
    });
  }

  Future<void> grabarYVerificarPalabraClave() async {
    final record = Record();
    final hasPermission = await record.hasPermission();
    if (!hasPermission) return;

    final dir = await getTemporaryDirectory();
    final path = p.join(dir.path, 'audio.wav');

    await record.start(
      path: path,
      encoder: AudioEncoder.wav,
      bitRate: 128000,
      samplingRate: 16000,
    );

    await Future.delayed(const Duration(seconds: 5));
    await record.stop();

    final file = File(path);
    if (!file.existsSync()) return;

    final req = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:8000/transcribe/'),
    );
    req.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await req.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final transcripcion =
          jsonDecode(responseBody)['text'].toString().toLowerCase();
      final keywords = await _keywordService.listarKeywords();
      final lista = keywords.map((k) => k.keywordName.toLowerCase()).toList();

      final coincidencia = lista.any((k) => transcripcion.contains(k));
      if (coincidencia) {
        await enviarMensajesDeAyuda();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Alerta enviada a contactos.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No se detectó ninguna palabra clave.")),
        );
      }
    } else {
      debugPrint("❌ Error al transcribir: $responseBody");
    }
  }

  Future<void> enviarMensajesDeAyuda() async {
    final contactos = await _trustedContactService.listarTrustedContacts();
    if (contactos.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ No hay contactos de confianza.")),
      );
      return;
    }

    for (final contact in contactos) {
      final numero = '51${contact.trustedContactCellPhone}';
      final mensaje = Uri.encodeComponent(
          '¡Necesito ayuda! Por favor, contáctame lo antes posible.');
      final wa = 'https://wa.me/$numero?text=$mensaje';
      final sms = 'sms:$numero?body=$mensaje';

      if (await canLaunchUrlString(wa)) await launchUrlString(wa);
      if (await canLaunchUrlString(sms)) await launchUrlString(sms);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                        isVoiceRecognitionActive
                            ? grabarYVerificarPalabraClave()
                            : enviarMensajesDeAyuda();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(50),
                        backgroundColor: Colors.blueAccent,
                        elevation: 10,
                      ),
                      child: const Text(
                        'HELP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
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
