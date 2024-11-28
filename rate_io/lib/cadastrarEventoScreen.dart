import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/evento.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';


class CadastrarEventoScreen extends StatefulWidget {
  @override
  _CadastrarEventoScreenState createState() => _CadastrarEventoScreenState();
}

class _CadastrarEventoScreenState extends State<CadastrarEventoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final MaskedTextController _dataController = MaskedTextController(mask: '00/00/0000');
  //final TextEditingController _quantidadePessoas = TextEditingController();

  int numeroPessoas = 0;
  String errorMessage = '';

  void _registerEvento() async {
    DateTime data;

    setState(() {
      errorMessage = '';
    });

    if (_nomeController.text.isEmpty ||
        _descricaoController.text.isEmpty ||
        _dataController.text.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    try {
      data = DateFormat('dd/MM/yyyy').parse(_dataController.text);
    } catch (e) {
      setState(() {
        errorMessage = 'Formato de data de nascimento inválido.';
      });
      return;
    }

    Rep? repUsuario = Provider.of<RepProvider>(context, listen: false).rep;

    if (repUsuario == null) {
      setState(() {
        errorMessage = 'Rep não identificada. Por favor, faça login novamente.';
      });
      return;
    }

    Evento newEvento = Evento(
      nome: _nomeController.text,
      data: data,
      descricao: _descricaoController.text,
      numeroPessoas: numeroPessoas,
      repId: repUsuario.id!
    );

    try {
      CollectionReference eventoCollection =
        FirebaseFirestore.instance.collection('eventos');
      
      String generatedEventoId = eventoCollection.doc().id;
      newEvento.id = generatedEventoId;

      await eventoCollection
          .doc(generatedEventoId)
          .set(newEvento.toMap());

      await FirebaseFirestore.instance
        .collection('republicas')
        .doc(repUsuario.id)
        .update({
          'eventos': FieldValue.arrayUnion([newEvento.id!])
        });

      Navigator.of(context).pushReplacementNamed('/homeScreen');
    } catch (e) {
      print("Erro ao salvar avaliação: $e");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Evento'),
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
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Evento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do evento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                //controller: _quantidadePessoas,
                decoration: InputDecoration(labelText: 'Número de pessoas'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o número de pessoas';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor, insira um número válido';
                  }
                  return null;
                },
                onChanged: (value) {
                  numeroPessoas = int.tryParse(value) ?? 0;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(labelText: 'Data do Evento'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a data do evento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(280),
                ],
              ),
              SizedBox(height: 16),
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
                      _registerEvento();
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