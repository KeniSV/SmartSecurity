import 'package:flutter_smartsecurity/Models/Keyword.dart';

class Keywordservice {
  final List<Keyword> _keywords = [];

  void agregarPalabraClave(Keyword keyword) {
    try {
      _keywords.add(keyword);
      print("Palabra clave '${keyword.keywordName}' agregada exitosamente.");
    } catch (e) {
      print("Error al agregar palabra clave: $e");
    }
  }

  void eliminarPalabraClave(int keywordID) {
    try {
      _keywords.removeWhere((keyword) => keyword.keywordID == keywordID);
      print("Palabra clave con ID $keywordID eliminada exitosamente.");
    } catch (e) {
      print("Error al eliminar la palabra clave: $e");
    }
  }

  List<Keyword> listarKeywords() {
    return _keywords;
  }
}
