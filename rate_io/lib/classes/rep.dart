import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rate_io/classes/morador.dart';

class Rep {
  String? id;
  String nome;
  DateTime anoFundacao;
  String endereco;
  int lotacao;
  String tipoSexo;
  String moradorADMId;

  List <String>? avaliacoesId;
  List <Morador>? moradores;
  List <String>? eventosId;

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
    this.eventosId,
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
      'avaliacoesId': avaliacoesId,
      'eventosId': eventosId,
    };
  }

  factory Rep.fromMap(Map<String, dynamic> map) {
    return Rep(

      id: map['id'],
      nome: map['nome'], 
      anoFundacao: (map['anoFundacao'] as Timestamp).toDate(), 
      endereco: map['endereco'], 
      lotacao: map['lotacao'], 
      tipoSexo: map['tipoSexo'],
      moradorADMId: map['moradorADMId'],
      avaliacoesId: map['avaliacoesId'] != null
        ? List<String>.from(map['avaliacoesId'])
        : null,
      eventosId: map['eventosId'] != null
        ? List<String>.from(map['eventosId'])
        : null,
    );
  }
}
