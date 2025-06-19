import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class TrackingService {
  final Location location = Location();
  Timer? _timer;
  Timer? _autoStopTimer;
  final int passengerId;
  final String baseUrl =
      'http://localhost:8000'; // Cambia a IP real si estás en dispositivo físico

  TrackingService(this.passengerId);

  /// Inicia el tracking periódico cada 10 segundos
  Future<void> iniciarTracking() async {
    final servicioActivo = await location.serviceEnabled();
    if (!servicioActivo && !await location.requestService()) {
      print("❌ Servicio de ubicación no habilitado.");
      return;
    }

    var permisos = await location.hasPermission();
    if (permisos == PermissionStatus.denied) {
      permisos = await location.requestPermission();
      if (permisos != PermissionStatus.granted) {
        print("❌ Permiso de ubicación no otorgado.");
        return;
      }
    }

    _timer =
        Timer.periodic(const Duration(seconds: 10), (_) => _enviarUbicacion());

    // Detener automáticamente después de 1 hora (3600 segundos)
    _autoStopTimer = Timer(const Duration(hours: 1), () {
      detenerTracking();
      print("⏱️ Tracking detenido automáticamente después de 1 hora.");
    });

    print("📡 Tracking iniciado para passenger_id: $passengerId");
  }

  /// Detiene el tracking
  void detenerTracking() {
    _timer?.cancel();
    _autoStopTimer?.cancel();
    print("🛑 Tracking detenido.");
  }

  /// Envía la ubicación actual al backend
  Future<void> _enviarUbicacion() async {
    try {
      final pos = await location.getLocation();

      final response = await http.post(
        Uri.parse('$baseUrl/location/update'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'passenger_id': passengerId,
          'latitude': pos.latitude,
          'longitude': pos.longitude,
        }),
      );

      if (response.statusCode == 200) {
        print("✅ Ubicación actualizada.");
      } else {
        print("❗ Error al enviar ubicación: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ Excepción durante el tracking: $e");
    }
  }
}
