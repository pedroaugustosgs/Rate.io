import 'package:rate_io/classes/morador.dart';

class Pagamento {
  String? id;
  double valorPago;
  DateTime dataPagamento;
  String moradorID;

  Pagamento({
    this.id,
    required this.valorPago,
    required this.dataPagamento,
    required this.moradorID,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valorPago': valorPago,
      'dataPagamento': dataPagamento,
      'moradorID': moradorID
    };
  }

  factory Pagamento.fromMap(Map<String, dynamic> map) {
    return Pagamento(
        valorPago: map['valorPago'],
        dataPagamento: map['dataPagamento'],
        moradorID: map['moradorID']);
  }
}
