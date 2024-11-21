import 'package:flutter/material.dart';

class CadastrarPagamentoScreen extends StatefulWidget {
  @override
  _CadastrarPagamentoScreenState createState() => _CadastrarPagamentoScreenState();
}

class _CadastrarPagamentoScreenState extends State<CadastrarPagamentoScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _descricao;
  double? _valor;
  DateTime? _dataPagamento;

  void _salvarPagamento() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Função para salvar os dados do pagamento
      // Adicione aqui a lógica para salvar os dados
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Pagamento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Voltar'),
                  ),
                  ElevatedButton(
                    onPressed: _salvarPagamento,
                    child: Text('Salvar'),
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