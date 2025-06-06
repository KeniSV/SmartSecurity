import 'package:flutter/material.dart';
import 'package:flutter_smartsecurity/PantalladeAgregarPalabraClave.dart';
import 'package:flutter_smartsecurity/Models/Keyword.dart';
import 'package:flutter_smartsecurity/Services/KeywordService.dart';

class PantalladePalabraClave extends StatefulWidget {
  const PantalladePalabraClave({super.key});

  @override
  _PantalladePalabraClaveState createState() => _PantalladePalabraClaveState();
}

class _PantalladePalabraClaveState extends State<PantalladePalabraClave> {
  final KeywordService _keywordService = KeywordService();
  List<Keyword> _keywords = [];
  Set<int> _selectedKeywordIDs = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _cargarKeywords();
  }

  Future<void> _cargarKeywords() async {
    setState(() => _loading = true);
    final lista = await _keywordService.listarKeywords();
    setState(() {
      _keywords = lista;
      _selectedKeywordIDs.clear();
      _loading = false;
    });
  }

  void _toggleSeleccion(int keywordID, bool selected) {
    setState(() {
      if (selected) {
        _selectedKeywordIDs.add(keywordID);
      } else {
        _selectedKeywordIDs.remove(keywordID);
      }
    });
  }

  Future<void> _eliminarSeleccionados() async {
    for (var id in _selectedKeywordIDs) {
      await _keywordService.eliminarKeyword(id);
    }
    await _cargarKeywords();
  }

  void _mostrarDialogoEliminacion() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Delete Keyword',
          style: TextStyle(color: Colors.red),
        ),
        content: const Text('Are you sure you want to delete this keyword?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Cierra el diálogo
              await _eliminarSeleccionados();
            },
            child: const Text('Yes'),
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
          onPressed: () => Navigator.pop(context),
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
            _loading
                ? const Center(child: CircularProgressIndicator())
                : _keywords.isEmpty
                    ? const Text("No keywords found.")
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _keywords.length,
                          itemBuilder: (context, index) {
                            final keyword = _keywords[index];
                            final id = keyword.keywordID;

                            if (id == null) return const SizedBox.shrink();

                            return CheckboxListTile(
                              title: Text(keyword.keywordName),
                              value: _selectedKeywordIDs.contains(id),
                              onChanged: (bool? value) {
                                _toggleSeleccion(id, value ?? false);
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            );
                          },
                        ),
                      ),
            const SizedBox(height: 16),
            const Center(
              child: Icon(
                Icons.vpn_key,
                size: 100,
                color: Color(0xFF0C1D60),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _selectedKeywordIDs.isEmpty
                  ? null
                  : _mostrarDialogoEliminacion,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Delete keyword'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantalladeAgregarPalabraClave(),
                  ),
                );
                _cargarKeywords(); // Recarga al volver
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0C1D60),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Add keyword',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
