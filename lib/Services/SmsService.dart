import 'package:flutter/services.dart';

class SmsService {
  static const platform = MethodChannel('com.smartsecurity/sms');

  Future<void> sendSms(String phoneNumber, String message) async {
    try {
      await platform.invokeMethod('sendSms', {
        'phoneNumber': phoneNumber,
        'message': message,
      });
    } on PlatformException catch (e) {
      print("Error al enviar SMS: '${e.message}'.");
    }
  }
}
