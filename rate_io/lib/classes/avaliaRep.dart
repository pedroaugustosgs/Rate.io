import 'package:rate_io/classes/avaliacao.dart';

class AvaliaRep extends Avaliacao {
  String? id;
  double pinga;
  double sossego;
  double limpeza;
  double resenha;
  double custo;
  String repId;
  String autorId;

  AvaliaRep(
      {this.id,
      required double estrela,
      String? comentario,
      required this.pinga,
      required this.sossego,
      required this.limpeza,
      required this.resenha,
      required this.repId,
      required this.autorId,
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
      'repId': repId,
      'autorId':autorId,
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
      repId: map['repId'],
      autorId: map['autorId']
    );
  }
}
