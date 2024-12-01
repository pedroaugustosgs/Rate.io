import 'package:rate_io/classes/avaliacao.dart';

class AvaliacaoMorador extends Avaliacao {
  String? id;
  double organizacao;
  double convivencia;
  double festivo;
  double responsavel;
  String moradorId;
  String autorId;



  AvaliacaoMorador({
    this.id,
    required double estrela,
    String? comentario,
    required this.organizacao,
    required this.convivencia,
    required this.festivo,
    required this.responsavel,
    required this.autorId,
    required this.moradorId}) 
    : super(
          estrela: estrela,
          comentario: comentario,
        );

  // Serializa a AvaliacaoMorador para um Map<String, dynamic>
  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'organizacao': organizacao,
      'convivencia': convivencia,
      'festivo': festivo,
      'responsavel': responsavel,
      'moradorId' : moradorId,
      'autorId': autorId,
      'estrela': estrela,
      'comentario': comentario,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de AvaliacaoMorador
  factory AvaliacaoMorador.fromMap(Map<String, dynamic> map) {
    return AvaliacaoMorador(
      id: map['id'],
      organizacao: map['organizacao'],
      convivencia: map['convivencia'],
      festivo: map['festivo'],
      responsavel: map['responsavel'],
      autorId: map['autorId'],
      moradorId: map['moradorId'],
      estrela: map['estrela'],
      comentario: map['comentario'],
    );
  }
}
