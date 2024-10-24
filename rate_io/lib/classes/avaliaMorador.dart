import 'package:rate_io/classes/avaliacao.dart';

class AvaliacaoMorador extends Avaliacao {
  String? id;
  int organizacao;
  int convivencia;
  int festivo;
  int responsavel;

  // Corrigido para inicialização correta no construtor
  int estrelaInput;
  String comentarioInput;

  AvaliacaoMorador({
    required this.id,
    required this.organizacao,
    required this.convivencia,
    required this.festivo,
    required this.responsavel,
    required this.estrelaInput, // Inicializa aqui
    required this.comentarioInput, // Inicializa aqui
  }) : super(
          estrela: estrelaInput,
          comentario: comentarioInput,
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
      'comentario': comentarioInput,
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
      comentarioInput: map['comentario'],
    );
  }
}
