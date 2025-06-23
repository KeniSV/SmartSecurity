import 'package:flutter/services.dart';

class CallService {
  static const platform = MethodChannel('com.smartsecurity/sms');

  Future<void> makeCall(String phoneNumber) async {
    try {
      await platform.invokeMethod('makeCall', {
        'phoneNumber': phoneNumber,
      });
    } on PlatformException catch (e) {
      print("Error al realizar la llamada: '${e.message}'.");
    }
  }
}
