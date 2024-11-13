import 'rep.dart';
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
  List<Morador>? avaliacaoes;
  List<Tarefa>? tarefas;
  List<Pagamento>? pagamentos;
  List<Gastos>? gastos;
  Rep? rep; // rep que ele mora

  Morador({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.sexo,
    required this.curso,
    required this.faculdade,
    required this.dataNascimento,
    this.avaliacaoes,
    this.tarefas,
    this.pagamentos,
    this.gastos,
    this.rep
  });

  // Serializa o Morador para um Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'sexo': sexo,
      'curso': curso,
      'faculdade': faculdade,
      'dataNascimento': dataNascimento,
      'avaliacoes': avaliacaoes,
      'tarefas': tarefas,
      'pagamentos': pagamentos,
      'gastos': gastos,
      'rep': rep,
    };
  }

  // Desserializa um Map<String, dynamic> para uma instância de Morador
  factory Morador.fromMap(Map<String, dynamic> map) {
    return Morador(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      telefone: map['telefone'],
      sexo: map['sexo'],
      curso: map['curso'],
      faculdade: map['faculdade'],
      dataNascimento: map['idade'],
      avaliacaoes: List<Morador>.from(map['avaliacoes']),
      tarefas: List<Tarefa>.from(map['tarefas']),
      pagamentos: List<Pagamento>.from(map['pagamentos']),
      gastos: List<Gastos>.from(map['gastos']),
      rep: map['rep'],
    );
  }
}
