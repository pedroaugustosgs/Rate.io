import 'package:rate_io/classes/rep.dart';

class Evento {
  String? id;
  String nome;
  DateTime data;
  String descricao;
  int numeroPessoas;
  Rep rep;

  Evento(
      {this.id,
      required this.nome,
      required this.data,
      required this.descricao,
      required this.numeroPessoas,
      required this.rep});
  // Serializa o Evento para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data': data.toIso8601String(), // Converte DateTime para String ISO 8601
      'descricao': descricao,
      'numeroPessoas': numeroPessoas,
      'rep': rep,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Evento
  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      id: map['id'],
      nome: map['nome'],
      data: DateTime.parse(
          map['data']), // Converte String ISO 8601 de volta para DateTime
      descricao: map['descricao'],
      numeroPessoas: map['numeroPessoas'],
      rep: map['rep'],
    );
  }
}
