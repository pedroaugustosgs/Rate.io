import 'dart:ffi';

import 'package:rate_io/classes/gastos.dart';
import 'package:rate_io/classes/morador.dart';

class DespesaModel extends GastosModel {
  String? id;
  int nome;
  Float valorTotal;
  DateTime dataVencimento;

  DespesaModel({
    required this.id,
    required this.nome,
    required this.valorTotal,
    required this.dataVencimento,
    required MoradorModel morador,
  }) : super(morador: morador);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valorTotal': valorTotal,
      'dataVencimento': dataVencimento,
      // Colocar aqui Rep rep
    };
  }
}
