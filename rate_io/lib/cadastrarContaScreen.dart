import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/despesas.dart';
import 'package:rate_io/classes/moradorProvider.dart';

class CadastrarContaScreen extends StatefulWidget {
  @override
  _CadastrarContaScreenState createState() => _CadastrarContaScreenState();
}

class _CadastrarContaScreenState extends State<CadastrarContaScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _nomeConta = '';
  double _valor = 0;
  DateTime _dataVencimento = DateTime.now();
  bool _paga = false;

  @override
  Widget build(BuildContext context) {
    final morador = Provider.of<MoradorProvider>(context).morador;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Conta'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome da Conta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome da conta';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nomeConta = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o valor';
                  }
                  return null;
                },
                onSaved: (value) {
                  _valor = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Data de Vencimento'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a data de vencimento';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dataVencimento = DateTime.parse(value!);
                },
              ),
              CheckboxListTile(
                title: Text('Paga'),
                value: _paga,
                onChanged: (bool? value) {
                  setState(() {
                    _paga = value ?? false;
                  });
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
                              .collection('despesa')
                              .doc();

                          // Pegar o ID gerado pelo Firestore
                          String generatedId = pagamentoRef.id;
                          Despesa newDespesa = Despesa(
                            id: generatedId,
                            nome: _nomeConta,
                            morador: morador.id!,
                            valorTotal: _valor,
                            dataVencimento: _dataVencimento,
                            isPaga: _paga
                          );
                          print(newDespesa);
                          // Salvar o objeto no Firestore
                          pagamentoRef.set({
                            'id': newDespesa.id,
                            'morador': newDespesa.morador,
                            'valorTotal': newDespesa.valorTotal,
                            'dataVencimento': newDespesa.dataVencimento,
                            'isPaga': newDespesa.isPaga
                          }).then((_) {
                            print('Despesa cadastrado com sucesso!');
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
