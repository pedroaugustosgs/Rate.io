import 'package:rate_io/classes/gastos.dart';
import 'package:rate_io/classes/morador.dart';

class Fracao extends Gastos {
  String? id;
  int valor;
  Morador morador;

  Fracao({
    this.id,
    required this.valor,
    required this.morador,
  }) : super(morador: morador);

  // Serializa o Tarefa para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'valor': valor,
      'morador': morador,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Tarefa
  factory Fracao.fromMap(Map<String, dynamic> map) {
    return Fracao(
      id: map['id'],
      valor: map['valor'],
      morador: map['morador'],
    );
  }
}
