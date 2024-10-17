import 'dart:ffi';

class ModelCaixa {
  String? id;
  DateTime mes;
  int ano;
  Float saldoAnterior;
  Float saldoAtual;

  ModelCaixa({
    this.id,
    required this.mes,
    required this.ano,
    required this.saldoAnterior,
    required this.saldoAtual
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mes': mes,
      'ano': ano,
      'saldoAnterior': saldoAnterior,
      'saldoAtual': saldoAtual,
    };
  }
}