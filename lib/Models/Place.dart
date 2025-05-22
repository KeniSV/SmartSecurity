class Place {
  int placeID;
  String placeName;
  String address;

  Place({
    required this.placeID,
    required this.placeName,
    required this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeID: json['placeID'],
      placeName: json['placeName'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeID': placeID,
      'placeName': placeName,
      'address': address,
    };
  }
}
