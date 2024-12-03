import 'package:cloud_firestore/cloud_firestore.dart';

//import 'rep.dart';
import 'tarefa.dart';
import 'gastos.dart';
import 'pagamento.dart';
import 'sexo.dart';

class Morador{
  String? id;
  String nome;
  String email;
  String telefone;
  Sexo sexo;
  String curso;
  String faculdade;
  DateTime dataNascimento;
  List<String>? avaliacoesId;
  List<Tarefa>? tarefas;
  List<Pagamento>? pagamentos;
  List<Gastos>? gastos;
  String? repId; // rep que ele mora
  List<String>? convitesId;

  Morador({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.sexo,
    required this.curso,
    required this.faculdade,
    required this.dataNascimento,
    this.avaliacoesId,
    this.tarefas,
    this.pagamentos,
    this.gastos,
    this.repId,
    this.convitesId
  });

  // Serializa o Morador para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'sexo': sexo.name,
      'curso': curso,
      'faculdade': faculdade,
      'dataNascimento': Timestamp.fromDate(dataNascimento),
      'avaliacoesId': avaliacoesId,
      'tarefas': tarefas?.map((a) => a.toMap()).toList(),
      'pagamentos': pagamentos?.map((a) => a.toMap()).toList(),
      'gastos': gastos?.map((a) => a.toMap()).toList(),
      'repId': repId,
      'convitesId': convitesId
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Morador
  factory Morador.fromMap(Map<String, dynamic> map) {
    return Morador(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      sexo: SexoExtension.fromString(map['sexo']),
      curso: map['curso'],
      faculdade: map['faculdade'],
      dataNascimento: (map['dataNascimento'] as Timestamp).toDate(), 
      avaliacoesId: map['avaliacoesId'] != null
        ? List<String>.from(map['avaliacoesId'])
        : null,

      tarefas: (map['tarefas'] as List<dynamic>?)
        ?.map((a) => Tarefa.fromMap(a as Map<String, dynamic>))
        .toList(),

      pagamentos: (map['pagamentos'] as List<dynamic>?)
        ?.map((a) => Pagamento.fromMap(a as Map<String, dynamic>))
        .toList(),

      gastos: (map['gastos'] as List<dynamic>?)
        ?.map((a) => Gastos.fromMap(a as Map<String, dynamic>))
        .toList(),
      repId: map['repId'],
      convitesId: map['convitesId'] != null
        ? List<String>.from(map['convitesId'])
        : null,
    );
  }
}
