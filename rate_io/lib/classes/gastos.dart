import 'package:rate_io/classes/despesas.dart';
import 'package:rate_io/classes/fracao.dart';
import 'package:rate_io/classes/morador.dart';

abstract class Gastos {
  Morador morador;

  Gastos({required this.morador});
  // Método abstrato para mapear os gastos e despesas
  Map<String, dynamic> toMap();  

  static Gastos fromMap(Map<String, dynamic> map) {
    switch(map['type']) {
      case 'Despesa':
        return Despesa.fromMap(map);
      case 'Fracao':
        return Fracao.fromMap(map);
      default:
        throw UnimplementedError('Unknown Gastos type: ${map['type']}');
    }
  }
}
