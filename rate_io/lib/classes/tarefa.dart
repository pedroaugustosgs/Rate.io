class Tarefa {
  String? id;
  String nome;
  DateTime data;
  int prioridade;
  String descricao;
  List <String> moradoresId;

  Tarefa({
    this.id,
    required this.nome,
    required this.data,
    required this.prioridade,
    required this.descricao,
    required this.moradoresId
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'nome':nome,
      'data': data,
      'prioridade': prioridade,
      'descricao': descricao,
      'moradoresId': moradoresId
    };
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      nome: map['nome'],
      data: map['data'],
      prioridade: map['prioridade'],
      descricao: map['descricao'],
      moradoresId: map['moradores']
    );
  }
}