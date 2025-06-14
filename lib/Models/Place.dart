class Place {
  int? placeID; // ✅ Ahora es opcional
  String placeName;
  String address;

  Place({
    this.placeID, // ✅ Ya no es obligatorio
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
      if (placeID != null)
        'placeID': placeID, // ✅ Solo se incluye si no es nulo
      'placeName': placeName,
      'address': address,
    };
  }
}
