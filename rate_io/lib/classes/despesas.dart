//import 'dart:ffi';

import 'package:rate_io/classes/gastos.dart';
import 'package:rate_io/classes/morador.dart';

class Despesa extends Gastos {
  String? id;
  String nome;
  double valorTotal;
  DateTime dataVencimento;
  bool isPaga;

  Despesa({
    required this.id,
    required this.nome,
    required this.valorTotal,
    required this.dataVencimento,
    required String morador,
    required  this.isPaga,
  }) : super(morador: morador);
  // Serializa a Despesa para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valorTotal': valorTotal,
      'dataVencimento': dataVencimento
          .toIso8601String(), // Converte DateTime para String ISO 8601
      'morador': morador,
      'isPaga': isPaga
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Despesa
  factory Despesa.fromMap(Map<String, dynamic> map) {
    return Despesa(
      id: map['id'],
      nome: map['nome'],
      valorTotal: map['valorTotal'],
      dataVencimento: DateTime.parse(map[
          'dataVencimento']), // Converte String ISO 8601 de volta para DateTime
      morador:
          map['morador'], // Certifique-se de que Morador tem o método fromMap()
          isPaga: map['isPaga']
    );
  }
}
