import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeAgregarMiLugar.dart';
import 'package:flutter_smartsecurity/Models/Driver.dart';
import 'package:flutter_smartsecurity/Models/Place.dart';
import 'package:flutter_smartsecurity/Models/TrustedContact.dart';
import 'package:flutter_smartsecurity/Services/PlaceService.dart';

class PantalladeMiLugar extends StatefulWidget {
  final Driver driver;
  final TrustedContact trustedcontact;
  final Place place;

  const PantalladeMiLugar({
    required this.driver,
    required this.trustedcontact,
    required this.place,
    super.key,
  });

  @override
  _PantalladeMiLugarState createState() => _PantalladeMiLugarState();
}

class _PantalladeMiLugarState extends State<PantalladeMiLugar> {
  final PlaceService placeService = PlaceService();
  List<Place> todosLosLugares = [];
  List<Place> lugaresFiltrados = [];
  String searchQuery = '';
  Place? lugarSeleccionado;

  @override
  void initState() {
    super.initState();
    listarLugares();
  }

  Future<void> listarLugares() async {
    final lugares = await placeService.listarLugares();
    setState(() {
      todosLosLugares = lugares;
      lugaresFiltrados = lugares;
      lugarSeleccionado = null;
    });
  }

  void buscarLugares(String query) async {
    final resultados = await placeService.buscarLugar(query);
    setState(() {
      searchQuery = query;
      lugaresFiltrados = resultados;
    });
  }

  void seleccionarLugar(Place lugar) {
    setState(() {
      lugarSeleccionado = lugar;
    });
  }

  void confirmarEliminarLugar() {
    if (lugarSeleccionado == null) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Are you sure you want to delete the place?',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        actionsAlignment: MainAxisAlignment.end,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await placeService.eliminarLugar(lugarSeleccionado!.placeID!);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Place successfully removed'),
                  backgroundColor: Colors.green,
                ),
              );
              listarLugares();
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'My place',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Keep the places you visit most frequently saved',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: buscarLugares,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Find your place',
                filled: true,
                fillColor: Colors.purple[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: lugaresFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'No places found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: lugaresFiltrados.length,
                      itemBuilder: (context, index) {
                        final lugar = lugaresFiltrados[index];
                        final isSelected =
                            lugarSeleccionado?.placeID == lugar.placeID;
                        return ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: isSelected ? Colors.blue : Colors.indigo,
                          ),
                          title: Text(
                            lugar.placeName,
                            style: TextStyle(
                              color: isSelected ? Colors.blue : Colors.black,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          subtitle: Text(lugar.address),
                          onTap: () => seleccionarLugar(lugar),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.location_on,
              size: 100,
              color: Colors.indigo,
            ),
            const SizedBox(height: 10),
            const Text(
              'Find and save the place you always visit to make it easier for you to choose the easiest route',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeAgregarMiLugar(
                      driver: widget.driver,
                      trustedcontact: widget.trustedcontact,
                      place: widget.place,
                    ),
                  ),
                );
                listarLugares();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Add place'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed:
                  lugarSeleccionado == null ? null : confirmarEliminarLugar,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text('Delete selected place'),
            ),
          ],
        ),
      ),
    );
  }
}
