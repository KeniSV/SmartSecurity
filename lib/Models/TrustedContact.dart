class TrustedContact {
  int trustedContactID;
  String trustedContactFullName;
  int trustedContactCodeCellPhone;
  int trustedContactCellPhone;
  String trustedContactEmail;

  TrustedContact({
    required this.trustedContactID,
    required this.trustedContactFullName,
    required this.trustedContactCodeCellPhone,
    required this.trustedContactCellPhone,
    required this.trustedContactEmail,
  });

  factory TrustedContact.fromJson(Map<String, dynamic> json) {
    return TrustedContact(
      trustedContactID: json['trustedContactID'],
      trustedContactFullName: json['trustedContactFullName'],
      trustedContactCodeCellPhone: json['trustedContactCodeCellPhone'],
      trustedContactCellPhone: json['trustedContactCellPhone'],
      trustedContactEmail: json['trustedContactEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trustedContactID': trustedContactID,
      'trustedContactFullName': trustedContactFullName,
      'trustedContactCodeCellPhone': trustedContactCodeCellPhone,
      'trustedContactCellPhone': trustedContactCellPhone,
      'trustedContactEmail': trustedContactEmail,
    };
  }
}
