import 'dart:ffi';

import 'package:rate_io/classes/morador.dart';

class Pagamento {
  String? id;
  Float valorPago;
  DateTime dataPagamento;
  Morador morador;

  Pagamento({
    this.id,
    required this.valorPago,
    required this.dataPagamento,
    required this.morador,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valorPago': valorPago,
      'dataPagamento': dataPagamento,
      'morador': morador
    };
  }

  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
        valorPago: map['valorPago'],
        dataPagamento: map['dataPagamento'],
        morador: map['morador']);
  }
}
