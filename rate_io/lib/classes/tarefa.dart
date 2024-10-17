import 'package:rate_io/classes/morador.dart';

class TarefaModel {
  String? id;
  DateTime data;
  int prioridade;
  String descricao;
  List <MoradorModel> moradores;

  TarefaModel({
    this.id,
    required this.data,
    required this.prioridade,
    required this.descricao,
    required this.moradores
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}