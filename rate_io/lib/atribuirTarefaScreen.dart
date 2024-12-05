import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'package:rate_io/classes/tarefa.dart';


class AtribuirTarefaScreen extends StatefulWidget {
  final Map<String, dynamic> morador;
  AtribuirTarefaScreen({required this.morador});

  @override
  _AtribuirTarefaScreenState createState() => _AtribuirTarefaScreenState();
}

class _AtribuirTarefaScreenState extends State<AtribuirTarefaScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final MaskedTextController _dataController = MaskedTextController(mask: '00/00/0000');
  final MaskedTextController _horaController = MaskedTextController(mask: '00:00');
  String? _id;
  double _prioridade = 0;
  String nomeUsuario = '';

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _id = widget.morador['id'];
    _fetchNomeUsuario();
  }

  
  void _fetchNomeUsuario() async {
    final usuarioAvaliadoDoc = await FirebaseFirestore.instance.collection('moradores').doc(_id).get();
    if (usuarioAvaliadoDoc.exists && usuarioAvaliadoDoc.data() != null) {
      setState(() {
        nomeUsuario = usuarioAvaliadoDoc.data()!['nome'];
      });
    }
  }

  void _registrarTarefa() async {
    DateTime dataHora;

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
      final DateTime data = DateFormat('dd/MM/yyyy').parse(_dataController.text);
      final String horaText = _horaController.text;
      final List<String> horaPartes = horaText.split(':');
      final int hora = int.parse(horaPartes[0]);
      final int minuto = int.parse(horaPartes[1]);

      dataHora = DateTime(data.year, data.month, data.day, hora, minuto);

    } catch (e) {
      setState(() {
        errorMessage = 'Formato de data ou horário inválido.';
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

    Tarefa newTarefa = Tarefa(
      nome: _nomeController.text,
      data: dataHora,
      descricao: _descricaoController.text,
      prioridade: _prioridade.round(),
      moradoresId: _id != null ? [_id!] : [],
    );

    try {
      CollectionReference tarefaCollection =
        FirebaseFirestore.instance.collection('tarefas');
      
      String generatedTarefaId = tarefaCollection.doc().id;
      newTarefa.id = generatedTarefaId;
      
      await tarefaCollection
          .doc(generatedTarefaId)
          .set(newTarefa.toMap());

      await FirebaseFirestore.instance
        .collection('moradores')
        .doc(_id)
        .update({
          'tarefas': FieldValue.arrayUnion([newTarefa.id!])
        });
    } catch (e) {
      print("Erro ao salvar avaliação: $e");
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Atribuir tarefa a ${nomeUsuario}'),
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
                decoration: InputDecoration(labelText: 'Nome da Tarefa'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do evento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Prioridade: ${_prioridade.round()}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).inputDecorationTheme.labelStyle?.color,
                )
              ),
              Slider(
                value: _prioridade,
                min: 0,
                max: 5,
                divisions: 5,
                label: _prioridade.round().toString(), 
                onChanged: (double newValue) {
                  setState(() {
                    _prioridade = newValue;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(labelText: 'Data da Tarefa'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira a data da tarefa';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _horaController,
                decoration: InputDecoration(labelText: 'Horário da Tarefa'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o horário da tarefa';
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
                    onPressed: () async {
                      _registrarTarefa();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tarefa atribuída com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Atribuir'),
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