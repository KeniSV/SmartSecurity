class Keyword {
  final int? keywordID; // ID opcional y solo lectura
  final String keywordName;

  Keyword({
    this.keywordID,
    required this.keywordName,
  });

  /// Crear instancia desde JSON (respuesta del backend)
  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(
      keywordID: json['keywordID'] as int?,
      keywordName: json['keywordName'] as String,
    );
  }

  /// Convertir instancia a JSON (para enviar al backend)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'keywordName': keywordName,
    };
    if (keywordID != null) {
      data['keywordID'] = keywordID;
    }
    return data;
  }
}
