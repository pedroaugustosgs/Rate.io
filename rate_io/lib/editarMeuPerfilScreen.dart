import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/moradorProvider.dart';

class EditarPerfilMoradorScreen extends StatefulWidget {
  @override
  _EditarPerfilMoradorScreenState createState() => _EditarPerfilMoradorScreenState();
}

class _EditarPerfilMoradorScreenState extends State<EditarPerfilMoradorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();
  final TextEditingController _faculdadeController = TextEditingController();
  final MaskedTextController _nascimentoController =
      MaskedTextController(mask: '00/00/0000');
  String errorMessage = '';

  void _salvarDados() async {
    DateTime? dataNascimento;
    setState(() {
      errorMessage = '';
    });

    try {
      if(_nascimentoController.text.isNotEmpty)
        dataNascimento = DateFormat('dd/MM/yyyy').parse(_nascimentoController.text);
    } catch (e) {
      print("Erro ao converter data: $e");
      return;
    }

    Morador? meuPerfil = Provider.of<MoradorProvider>(context, listen: false).morador;
    if (meuPerfil == null) {
      setState(() {
        errorMessage = 'Perfil não identificado. Por favor, faça login novamente.';
      });
      return;
    }

    Map<String, dynamic> updates = {};  
    try {
      if (_telefoneController.text.isNotEmpty) {
        updates['telefone'] = _telefoneController.text;
      }
      if (_faculdadeController.text.isNotEmpty) {
        updates['faculdade'] = _faculdadeController.text;
      }
      if (_cursoController.text.isNotEmpty) {
        updates['curso'] = _cursoController.text; 
      }
      if (dataNascimento != null) {
        updates['dataNascimento'] = dataNascimento;
      }

      if (updates.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('moradores')
            .doc(meuPerfil.id)
            .update(updates);
      }
    } catch (e) {
      print("Erro ao salvar usuário: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Meu Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Preencha somente os dados que deseja alterar:",
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                controller: _telefoneController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Curso'),
                controller: _cursoController,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Faculdade'),
                controller: _faculdadeController,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                controller: _nascimentoController,
                decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        hintText: 'dd/MM/yyyy',
                      ),
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
                    onPressed: () async {
                      _salvarDados();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Atualização feita com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    },
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