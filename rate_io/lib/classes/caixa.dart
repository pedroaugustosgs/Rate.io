import 'dart:ffi';

class Caixa {
  String? id;
  DateTime mes;
  int ano;
  Float saldoAnterior;
  Float saldoAtual;

  Caixa(
      {this.id,
      required this.mes,
      required this.ano,
      required this.saldoAnterior,
      required this.saldoAtual});

  // Serializa o Caixa para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mes': mes,
      'ano': ano,
      'saldoAnterior': saldoAnterior,
      'saldoAtual': saldoAtual,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Caixa
  factory Caixa.fromMap(Map<String, dynamic> map) {
    return Caixa(
      id: map['id'],
      mes: map['mes'],
      ano: map['ano'],
      saldoAnterior: map['saldoAnterior'],
      saldoAtual: map['saldoAtual'],
    );
  }
}
