import 'package:rate_io/classes/avaliacao.dart';

class AvaliaMorador extends AvaliacaoModel {
  String? id;
  int organizacao;
  int convivencia;
  int festivo;
  int responsavel;
  int estrelaInput = 5;
  String comentarioInput =
      'Cara é brabo enzo sério mesmo garoto bom esse Gustavo viu :)';

  AvaliaMorador(
      {required this.id,
      required this.organizacao,
      required this.convivencia,
      required this.festivo,
      required this.responsavel,
      required int estrelaInput,
      required String comentarioInput})
      : super(
          estrela: estrelaInput,
          comentario: comentarioInput,
        );
  Map<String, dynamic> toMap() {
    return {
      'organizacao': '5',
      'comentario': 'Gustavo Marquardt é o melhor programador do mundo',
      //Essa também enzo, esta herdando aquela de Evento e teria que colocar o resto dos atributos
    };
  }
}
