import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/Models/Keyword.dart';
import 'package:flutter_smartsecurity/Services/KeywordService.dart';

class PantalladeAgregarPalabraClave extends StatefulWidget {
  const PantalladeAgregarPalabraClave({super.key});

  @override
  _PantalladeAgregarPalabraClaveState createState() =>
      _PantalladeAgregarPalabraClaveState();
}

class _PantalladeAgregarPalabraClaveState
    extends State<PantalladeAgregarPalabraClave> {
  final TextEditingController _keywordController = TextEditingController();
  final KeywordService _keywordService = KeywordService();
  bool _isLoading = false;

  void _guardarPalabraClave() async {
    final nombre = _keywordController.text.trim();

    if (nombre.isEmpty) {
      _mostrarDialogo("⚠️ Campo vacío, completar.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final nuevaKeyword = Keyword(keywordName: nombre); // Sin keywordID

    try {
      await _keywordService.crearKeyword(nuevaKeyword);
      _mostrarDialogo("✅ Keyword saved successfully", cerrarPantalla: true);
    } catch (e) {
      _mostrarDialogo("❌ Error al crear palabra clave:\n$e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _mostrarDialogo(String mensaje, {bool cerrarPantalla = false}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
              if (cerrarPantalla) {
                Navigator.pop(context); // Cierra la pantalla actual

                // Muestra SnackBar con mensaje
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Palabra clave agregada"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

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
                onPressed: _isLoading ? null : _guardarPalabraClave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C1D60),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
