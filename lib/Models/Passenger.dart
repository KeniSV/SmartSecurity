class Passenger {
  int passengerID;
  String passengerfirstName;
  String passengerlastname;
  String passengeremail;
  int passengerdocumentID;
  String passengerdocumentType;
  int passengercellPhone;
  int passengercodecellPhone;

  //Atributos para Login
  String passengerpassword;
  bool isActive = true;
  DateTime lastLogin = DateTime.now();

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
  });
}
