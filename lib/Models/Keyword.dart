class Keyword {
  int keywordID;
  String keywordName;

  Keyword({
    required this.keywordID,
    required this.keywordName,
  });

  /// Crear instancia desde JSON (usado al recibir datos del backend)
  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(
      keywordID: json['keywordID'],
      keywordName: json['keywordName'],
    );
  }

  /// Convertir instancia a JSON (usado al enviar datos al backend)
  Map<String, dynamic> toJson() {
    return {
      'keywordID': keywordID,
      'keywordName': keywordName,
    };
  }
}
