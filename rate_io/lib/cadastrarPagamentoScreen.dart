import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/classes/pagamento.dart';

class CadastrarPagamentoScreen extends StatefulWidget {
  @override
  _CadastrarPagamentoScreenState createState() =>
      _CadastrarPagamentoScreenState();
}

class _CadastrarPagamentoScreenState extends State<CadastrarPagamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _descricao;
  double? _valor;
  DateTime? _dataPagamento;
  String? _id;

  @override
  Widget build(BuildContext context) {
    final morador = Provider.of<MoradorProvider>(context).morador;
    print(morador);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Pagamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onSaved: (value) {
                  _descricao = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a descrição';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _valor = double.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data de Pagamento'),
                keyboardType: TextInputType.datetime,
                onSaved: (value) {
                  _dataPagamento = DateTime.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de pagamento';
                  }
                  if (DateTime.tryParse(value) == null) {
                    return 'Por favor, insira uma data válida';
                  }
                  return null;
                },
              ),
              Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (morador != null && morador.id != null) {
                          // Criar uma referência ao Firestore com ID gerado automaticamente
                          final pagamentoRef = FirebaseFirestore.instance
                              .collection('pagamento')
                              .doc();

                          // Pegar o ID gerado pelo Firestore
                          String generatedId = pagamentoRef.id;

                          // Criar um novo objeto Pagamento com o ID atribuído
                          Pagamento newPagamento = Pagamento(
                            id: generatedId,
                            moradorID: morador.id!,
                            valorPago: _valor!,
                            dataPagamento: _dataPagamento!,
                          );
                          print(newPagamento);
                          // Salvar o objeto no Firestore
                          pagamentoRef.set({
                            'id': newPagamento.id,
                            'moradorID': newPagamento.moradorID,
                            'valorPago': newPagamento.valorPago,
                            'dataPagamento': newPagamento.dataPagamento,
                          }).then((_) {
                            print('Pagamento cadastrado com sucesso!');
                            Navigator.of(context)
                                .pushReplacementNamed('/fluxoDeCaixaScreen');
                          }).catchError((error) {
                            print('Erro ao cadastrar pagamento: $error');
                          });
                        } else {
                          print('Erro: Morador ou ID do morador é nulo.');
                        }
                      }
                    },
                    child: Text('Salvar'),
                  
              ),
            ],
          ),
        ),
      ),
    );
  }
}
