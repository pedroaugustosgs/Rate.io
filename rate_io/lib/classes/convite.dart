class Convite {
  String? id;
  String repId;
  String descricao;
  //data de validade do convite

  Convite({
    this.id,
    required this.repId,
    required this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'repId': repId,
      'descricao': descricao,
    };
  }

  factory Convite.fromMap(Map<String, dynamic> map) {
    return Convite(
      id: map['id'],
      repId: map['repId'],
      descricao: map['descricao'],
    );
  }
}