class TrustedContact {
  final int? trustedContactID;
  final String trustedContactFullName;
  final int trustedContactCodeCellPhone;
  final int trustedContactCellPhone;
  final String trustedContactEmail;

  TrustedContact({
    this.trustedContactID,
    required this.trustedContactFullName,
    required this.trustedContactCodeCellPhone,
    required this.trustedContactCellPhone,
    required this.trustedContactEmail,
  });

  factory TrustedContact.fromJson(Map<String, dynamic> json) {
    return TrustedContact(
      trustedContactID: json['trustedContactID'] as int?,
      trustedContactFullName: json['trustedContactFullName'],
      trustedContactCodeCellPhone: json['trustedContactCodeCellPhone'],
      trustedContactCellPhone: json['trustedContactCellPhone'],
      trustedContactEmail: json['trustedContactEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'trustedContactFullName': trustedContactFullName,
      'trustedContactCodeCellPhone': trustedContactCodeCellPhone,
      'trustedContactCellPhone': trustedContactCellPhone,
      'trustedContactEmail': trustedContactEmail,
    };
    if (trustedContactID != null) {
      data['trustedContactID'] = trustedContactID!;
    }
    return data;
  }
}
