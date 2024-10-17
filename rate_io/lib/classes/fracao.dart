import 'package:rate_io/classes/gastos.dart';
import 'package:rate_io/classes/morador.dart';

class TarefaModel extends GastosModel {
  String? id;
  int valor;
  MoradorModel morador;

  TarefaModel({
    this.id,
    required this.valor,
    required this.morador,
  }) : super(morador: morador);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
    };
  }
}
