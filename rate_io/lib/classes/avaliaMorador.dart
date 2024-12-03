import 'package:rate_io/classes/avaliacao.dart';

class AvaliacaoMorador extends Avaliacao {
  String? id;
  double organizacao;
  double convivencia;
  double festivo;
  double responsavel;

  // Corrigido para inicialização correta no construtor
  double estrelaInput;
  String? comentario;

  AvaliacaoMorador({
    required this.id,
    required this.organizacao,
    required this.convivencia,
    required this.festivo,
    required this.responsavel,
    required this.estrelaInput, // Inicializa aqui
    this.comentario, 
  }) : super(
          estrela: estrelaInput,
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
      'estrela': estrelaInput,
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
      estrelaInput: map['estrela'],
      comentario: map['comentario'],
    );
  }
}
