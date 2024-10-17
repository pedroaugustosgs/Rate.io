import 'package:rate_io/classes/avaliacao.dart';

class AvaliaRepModel extends AvaliacaoModel {
  String? id;
  int pinga;
  int sossego;
  int limpeza;
  int resenha;
  int custo;

  AvaliaRepModel({
    required this.id,
    required int estrela,
    required String comentario,
    required this.pinga,  // Inicializando o atributo local 
    required this.sossego,
    required this.limpeza,
    required this.resenha,
    required this.custo  
  }) : super(
          estrela: estrela,
          comentario: comentario,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'estrela': estrela.toString(),
      'comentario': comentario,
      // e o resto dos atributos
    };
  }
}