import 'package:rate_io/classes/avaliacao.dart';

class AvaliaRep extends Avaliacao {
  String? id;
  int pinga;
  int sossego;
  int limpeza;
  int resenha;
  int custo;

  AvaliaRep(
      {required this.id,
      required int estrela,
      required String comentario,
      required this.pinga, // Inicializando o atributo local
      required this.sossego,
      required this.limpeza,
      required this.resenha,
      required this.custo})
      : super(
          estrela: estrela,
          comentario: comentario,
        );

// Serializa a AvaliaRep para um Map<String, dynamic>
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estrela': estrela,
      'comentario': comentario,
      'pinga': pinga,
      'sossego': sossego,
      'limpeza': limpeza,
      'resenha': resenha,
      'custo': custo,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de AvaliaRep
  factory AvaliaRep.fromMap(Map<String, dynamic> map) {
    return AvaliaRep(
      id: map['id'],
      estrela: map['estrela'],
      comentario: map['comentario'],
      pinga: map['pinga'],
      sossego: map['sossego'],
      limpeza: map['limpeza'],
      resenha: map['resenha'],
      custo: map['custo'],
    );
  }
}
