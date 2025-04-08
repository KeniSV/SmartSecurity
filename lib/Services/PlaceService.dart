import 'package:flutter_smartsecurity/Models/Place.dart';

class Placeservice {
  final List<Place> _places = [];

  void agregarLugar(Place lugar) {
    try {
      _places.add(lugar);
    } catch (e) {
      print("Error al agregar el lugar");
    }
  }

  void eliminarLugar(int placeID) {
    try {
      _places.removeWhere((lugar) => lugar.placeID == placeID);
      print("Lugar con ID $placeID eliminado exitosamente.");
    } catch (e) {
      print("Error al eliminar el lugar: $e");
    }
  }

  List<Place> listarPlaces() {
    return _places;
  }

  List<Place> buscarLugar(String nombre) {
    return _places.where((lugar) => lugar.placeName.contains(nombre)).toList();
  }
}
