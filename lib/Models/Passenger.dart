class Passenger {
  int passengerID;
  String passengerfirstName;
  String passengerlastname;
  String passengeremail;
  int passengerdocumentID;
  String passengerdocumentType;
  int passengercellPhone;
  int passengercodecellPhone;

  String passengerpassword;
  bool isActive;
  DateTime lastLogin;

  Passenger({
    required this.passengerID,
    required this.passengerfirstName,
    required this.passengerlastname,
    required this.passengeremail,
    required this.passengerdocumentID,
    required this.passengerdocumentType,
    required this.passengercellPhone,
    required this.passengercodecellPhone,
    required this.passengerpassword,
    bool? isActive,
    DateTime? lastLogin,
  })  : isActive = isActive ?? true,
        lastLogin = lastLogin ?? DateTime.now();

  /// 🔁 Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'passengerID': passengerID,
      'passengerFirstName': passengerfirstName,
      'passengerLastName': passengerlastname,
      'passengerEmail': passengeremail,
      'passengerDocumentID': passengerdocumentID,
      'passengerDocumentType': passengerdocumentType,
      'passengerCellPhone': passengercellPhone,
      'passengerCodeCellPhone': passengercodecellPhone,
      'passengerPassword': passengerpassword,
      'isActive': isActive,
      'lastLogin': lastLogin.toIso8601String(),
    };
  }

  /// 🔁 Convertir desde JSON
  factory Passenger.fromJson(Map<String, dynamic> json) {
    return Passenger(
      passengerID: json['passengerID'],
      passengerfirstName: json['passengerFirstName'],
      passengerlastname: json['passengerLastName'],
      passengeremail: json['passengerEmail'],
      passengerdocumentID: json['passengerDocumentID'],
      passengerdocumentType: json['passengerDocumentType'].toString(),
      passengercellPhone: json['passengerCellPhone'],
      passengercodecellPhone: json['passengerCodeCellPhone'],
      passengerpassword: json['passengerPassword'],
      isActive: json['isActive'],
      lastLogin: DateTime.tryParse(json['lastLogin'] ?? '') ?? DateTime.now(),
    );
  }
}
