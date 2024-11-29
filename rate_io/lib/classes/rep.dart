import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_io/classes/evento.dart';
import 'package:rate_io/classes/morador.dart';

class Rep {
  String? id;
  String nome;
  DateTime anoFundacao;
  String endereco;
  int lotacao;
  String tipoSexo;
  String moradorADMId;
  List<String>? avaliacoesId;
  List<Morador>? moradores;
  List<Evento>? eventos;

  Rep({
    this.id,
    required this.nome,
    required this.anoFundacao,
    required this.endereco,
    required this.lotacao,
    required this.tipoSexo,
    required this.moradorADMId,
    this.avaliacoesId,
    this.moradores,
    this.eventos,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'anoFundacao': Timestamp.fromDate(anoFundacao),
      'endereco': endereco,
      'lotacao': lotacao,
      'tipoSexo': tipoSexo,
      'moradorADMId': moradorADMId,
      'avaliacoesID': avaliacoesId,
    };
  }

  factory Rep.fromMap(Map<String, dynamic> map) {
    return Rep(
      id: map['id'] as String?,
      nome: map['nome'] as String,
      anoFundacao: (map['anoFundacao'] as Timestamp).toDate(),
      endereco: map['endereco'] as String,
      lotacao: map['lotacao'] as int,
      tipoSexo: map['tipoSexo'] as String,
      moradorADMId: map['moradorADMId'] as String,
      avaliacoesId: (map['avaliacoesId'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(), // Converte para List<String>
    );
  }
}
