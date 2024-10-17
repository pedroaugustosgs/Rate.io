import 'package:rate_io/classes/rep.dart';

class EventoModel {
  String? id;
  String nome;
  DateTime data;
  String descricao;
  int numeroPessoas;
  RepModel rep;


  EventoModel({
    this.id,
    required this.nome,
    required this.data,
    required this.descricao,
    required this.numeroPessoas,
    required this.rep
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
