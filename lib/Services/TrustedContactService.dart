import 'package:flutter_smartsecurity/Models/TrustedContact.dart';

class TrustedContactService {
  final List<TrustedContact> _trustedContacts = [];

  void agregarContacto(TrustedContact contacto) {
    try {
      _trustedContacts.add(contacto);
      print(
          "Contacto de confianza '${contacto.trustedContactFullName}' agregado exitosamente.");
    } catch (e) {
      print("Error al agregar el contacto");
    }
  }

  void eliminarContacto(int contactoID) {
    try {
      _trustedContacts
          .removeWhere((contacto) => contacto.trustedContactID == contactoID);
    } catch (e) {
      print("Error al eliminar el contacto: $e");
    }
  }

  List<TrustedContact> listarTrustedContact() {
    return _trustedContacts;
  }

  List<TrustedContact> buscarTrustedContact(String nombre) {
    return _trustedContacts
        .where((contacto) => contacto.trustedContactFullName.contains(nombre))
        .toList();
  }
}
