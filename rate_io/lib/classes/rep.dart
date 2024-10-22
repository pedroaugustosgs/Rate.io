import 'package:rate_io/classes/avaliaRep.dart';
import 'package:rate_io/classes/evento.dart';
import 'package:rate_io/classes/morador.dart';

class Rep {
  String? id;
  String nome;
  DateTime anoFundacao;
  String endereco;
  int lotacao;
  String tipoSexo;
  Morador? moradorADM;
  List <AvaliaRep>? avaliacoes;
  List <Morador>? moradores;
  List <Evento>? eventos;

  Rep({
    this.id,
    required this.nome,
    required this.anoFundacao,
    required this.endereco,
    required this.lotacao,
    required this.tipoSexo,
    // moradorADM esta como não obrigatório por enquanto para não quebrar nosso código enzo kkkkkk
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

  factory Rep.fromMap(Map<String, dynamic> map) {
    return Rep(
    nome: map['nome'], 
    anoFundacao: map['anoFundacao'], 
    endereco: map['endereco'], 
    lotacao: map['lotacao'], 
    tipoSexo: map['tipoSexo'],
    );
  }
}