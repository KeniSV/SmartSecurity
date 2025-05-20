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

  const PantalladeMiLugar(
      {required this.driver,
      required this.trustedcontact,
      required this.place,
      super.key});

  @override
  _PantalladeMiLugarState createState() => _PantalladeMiLugarState();
}

class _PantalladeMiLugarState extends State<PantalladeMiLugar> {
  final Placeservice placeService = Placeservice();
  List<Place> lugares = [];
  String searchQuery = '';
  Place? lugarSeleccionado;

  @override
  void initState() {
    super.initState();
    listarLugares();
  }

  void listarLugares() {
    setState(() {
      lugares = placeService.listarPlaces();
    });
  }

  void buscarLugares(String query) {
    setState(() {
      searchQuery = query;
      lugares = placeService.buscarLugar(query);
    });
  }

  void seleccionarLugar(Place lugar) {
    setState(() {
      lugarSeleccionado = lugar; // Marca el lugar seleccionado
    });
  }

  void eliminarLugarSeleccionado() {
    if (lugarSeleccionado != null) {
      placeService.eliminarLugar(lugarSeleccionado!.placeID);
      listarLugares();
      setState(() {
        lugarSeleccionado =
            null; // Desmarca el lugar seleccionado después de eliminarlo
      });
    }
  }

  void eliminarLugar(int placeID) {
    placeService.eliminarLugar(placeID);
    listarLugares();
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
              child: lugares.isEmpty
                  ? const Center(
                      child: Text(
                        'No places found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: lugares.length,
                      itemBuilder: (context, index) {
                        final lugar = lugares[index];
                        return ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: lugarSeleccionado == lugar
                                ? Colors
                                    .blue // Color destacado para el seleccionado
                                : Colors.indigo,
                          ),
                          title: Text(
                            lugar.placeName,
                            style: TextStyle(
                              color: lugarSeleccionado == lugar
                                  ? Colors.blue
                                  : Colors.black,
                              fontWeight: lugarSeleccionado == lugar
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          onTap: () => seleccionarLugar(lugar),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => eliminarLugar(lugar.placeID),
                          ),
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
              onPressed: () {
                // Navegar a PantalladeAgregarMiLugar
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PantalladeAgregarMiLugar(
                          driver: widget.driver,
                          trustedcontact: widget.trustedcontact,
                          place: widget.place)),
                ).then((_) => listarLugares());
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
              onPressed: eliminarLugarSeleccionado,
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
