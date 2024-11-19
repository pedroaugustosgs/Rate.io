import 'package:flutter/material.dart';

class EditarPerfilMoradorScreen extends StatefulWidget {
  @override
  _EditarPerfilMoradorScreenState createState() => _EditarPerfilMoradorScreenState();
}

class _EditarPerfilMoradorScreenState extends State<EditarPerfilMoradorScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _telefone;
  String? _curso;
  String? _faculdade;
  int? _idade;

  void _salvarDados() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Função para salvar os dados alterados
      // Adicione aqui a lógica para salvar os dados
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil do Morador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  _telefone = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Curso'),
                onSaved: (value) {
                  _curso = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o curso';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Faculdade'),
                onSaved: (value) {
                  _faculdade = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a faculdade';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _idade = int.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a idade';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
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
                    onPressed: _salvarDados,
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