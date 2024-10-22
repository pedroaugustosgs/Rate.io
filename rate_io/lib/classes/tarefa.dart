import 'package:rate_io/classes/morador.dart';

class Tarefa {
  String? id;
  DateTime data;
  int prioridade;
  String descricao;
  List <Morador> moradores;

  Tarefa({
    this.id,
    required this.data,
    required this.prioridade,
    required this.descricao,
    required this.moradores
  });

// Essas duas funções — toMap() e fromMap() — são responsáveis por serializar e 
// desserializar os dados da sua classe Tarefa em Dart. Elas permitem converter a classe em um 
// formato que pode ser facilmente manipulado, armazenado ou transferido (por exemplo, para o Firebase, 
// um arquivo JSON, etc.), e também reconverter os dados armazenados em uma instância da classe Tarefa.
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'data': data,
      'prioridade': prioridade,
      'descricao': descricao,
      'moradores': moradores
    };
  }

  // Converte de Map para instância de Tarefa
  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      data: map['data'],
      prioridade: map['prioridade'],
      descricao: map['descricao'],
      moradores: map['moradores']
    );
  }
}