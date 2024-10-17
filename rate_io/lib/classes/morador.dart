// TODO MUNDO LIGADO CERTINHO
import 'avaliaMorador.dart';
import 'rep.dart';
import 'tarefa.dart';
import 'gastos.dart';
import 'pagamento.dart';
import 'sexo.dart';

class MoradorModel {
  String? id;
  String nome;
  String email;
  String telefone;
  Sexo sexo;
  String curso;
  String faculdade;
  int idade;
  List<AvaliaMorador> avaliacaoes;
  List<TarefaModel> tarefas;
  List<PagamentoModel> pagamentos;
  List<GastosModel> gastos;
  RepModel rep; // rep que ele mora

  MoradorModel({
    this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.sexo,
    required this.curso,
    required this.faculdade,
    required this.idade,
    required this.avaliacaoes,
    required this.tarefas,
    required this.pagamentos,
    required this.gastos,
    required this.rep
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
