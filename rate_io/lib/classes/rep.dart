class RepModel {
  String? id;
  String nome;
  DateTime anoFundacao;
  String endereco;
  int lotacao;
  String tipoSexo;

  RepModel({
    this.id,
    required this.nome,
    required this.anoFundacao,
    required this.endereco,
    required this.lotacao,
    required this.tipoSexo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'anoFundacao': anoFundacao,
      'endereco': endereco,
      'lotacao': lotacao,
      'tipoSexo': tipoSexo,
    };
  }
}