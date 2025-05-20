import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeAgregarPalabraClave.dart';

class PantalladePalabraClave extends StatefulWidget {
  const PantalladePalabraClave({super.key});

  @override
  _PantalladePalabraClave createState() => _PantalladePalabraClave();
}

class _PantalladePalabraClave extends State<PantalladePalabraClave> {
  bool helpSelected = false;
  bool dangerSelected = false;
  bool impostorSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "My keyword",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keep your keywords saved',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Help'),
              value: helpSelected,
              onChanged: (bool? value) {
                setState(() {
                  helpSelected = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Danger'),
              value: dangerSelected,
              onChanged: (bool? value) {
                setState(() {
                  dangerSelected = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text('Impostor'),
              value: impostorSelected,
              onChanged: (bool? value) {
                setState(() {
                  impostorSelected = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 32),
            const Center(
              child: Icon(
                Icons.vpn_key,
                size: 100,
                color: Color(0xFF0C1D60),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Acción para guardar la palabra clave
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Reemplaza `primary`
                foregroundColor: Colors.black, // Reemplaza `onPrimary`
                side: const BorderSide(color: Colors.black),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Save'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Acción para añadir una nueva palabra clave
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantalladeAgregarPalabraClave(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C1D60), // Reemplaza `primary`
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Add keyword',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Acción para eliminar la palabra clave
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100, // Reemplaza `primary`
                foregroundColor: Colors.red, // Reemplaza `onPrimary`
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Delete keyword'),
            ),
          ],
        ),
      ),
    );
  }
}
