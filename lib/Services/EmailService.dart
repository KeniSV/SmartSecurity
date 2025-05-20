import 'package:flutter_smartsecurity/Models/Email.dart';

class EmailService {
  final List<Email> _emails = [];

  void agregarIncidente(Email email) {
    try {
      _emails.add(email);
      print("Incidente '${email.subjectEmail}' enviado exitosamente.");
    } catch (e) {
      print("Error al enviar el incidente: $e");
    }
  }

  List<Email> listarIncidentes() {
    return _emails;
  }
}
