import 'dart:ffi';

import 'package:rate_io/classes/morador.dart';

class PagamentoModel {
  String? id;
  Float valorPago;
  DateTime dataPagamento;
  MoradorModel morador;

  PagamentoModel({
    this.id,
    required this.valorPago,
    required this.dataPagamento,
    required this.morador,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}