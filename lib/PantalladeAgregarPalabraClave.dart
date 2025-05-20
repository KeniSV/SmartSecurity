import 'package:flutter/material.dart';

class PantalladeAgregarPalabraClave extends StatefulWidget {
  const PantalladeAgregarPalabraClave({super.key});

  @override
  _PantalladeAgregarPalabraClaveState createState() =>
      _PantalladeAgregarPalabraClaveState();
}

class _PantalladeAgregarPalabraClaveState
    extends State<PantalladeAgregarPalabraClave> {
  final TextEditingController _keywordController = TextEditingController();

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
            const SizedBox(height: 16),
            TextField(
              controller: _keywordController,
              decoration: InputDecoration(
                hintText: 'Enter your keyword',
                filled: true,
                fillColor: const Color(0xFFEDE7FE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para guardar la palabra clave
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                      0xFF0C1D60), // Cambié `primary` por `backgroundColor`
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }
}
