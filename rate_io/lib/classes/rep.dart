import 'package:rate_io/classes/avaliaRep.dart';
import 'package:rate_io/classes/evento.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/sexo.dart';

class RepModel {
  String? id;
  String nome;
  DateTime anoFundacao;
  String endereco;
  int lotacao;
  String tipoSexo;
  MoradorModel? moradorADM;
  List <AvaliaRepModel>? avaliacoes;
  List <MoradorModel>? moradores;
  List <EventoModel>? eventos;

  RepModel({
    this.id,
    required this.nome,
    required this.anoFundacao,
    required this.endereco,
    required this.lotacao,
    required this.tipoSexo,
    this.avaliacoes,
    this.moradorADM,
    this.moradores,
    this.eventos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'anoFundacao': anoFundacao,
      'endereco': endereco,
      'lotacao': lotacao,
      'tipoSexo': tipoSexo,
    };
  }
}