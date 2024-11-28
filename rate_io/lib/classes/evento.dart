import 'package:cloud_firestore/cloud_firestore.dart';

class Evento {
  String? id;
  String nome;
  DateTime data;
  String descricao;
  int numeroPessoas;
  String repId;

  Evento(
      {this.id,
      required this.nome,
      required this.data,
      required this.descricao,
      required this.numeroPessoas,
      required this.repId});
  // Serializa o Evento para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data': Timestamp.fromDate(data), // Converte DateTime para String ISO 8601
      'descricao': descricao,
      'numeroPessoas': numeroPessoas,
      'rep': repId,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Evento
  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      id: map['id'],
      nome: map['nome'],
      data: (map['data'] as Timestamp).toDate(),
      descricao: map['descricao'],
      numeroPessoas: map['numeroPessoas'],
      repId: map['rep'],
    );
  }
}
