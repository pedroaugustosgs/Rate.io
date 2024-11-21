import 'package:flutter/material.dart';

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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Aqui você pode adicionar a lógica para salvar os dados
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Cadastrar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}