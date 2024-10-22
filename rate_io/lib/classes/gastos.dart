import 'package:rate_io/classes/morador.dart';

abstract class Gastos {
  Morador morador;

  Gastos({required this.morador});
  // Método abstrato para mapear os gastos e despesas
  Map<String, dynamic>
      toMap(); // Imagino que aqui a gente coloque as funções que devem ser implementadas
  // Enzo deixei essa função aqui se não fica acusando erro, nosso projeto funciona em partes, essa é a função
  // que estamos usando para mapear os valores da classe e relacionar com o banco
}
