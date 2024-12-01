import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/avaliaMorador.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/moradorProvider.dart';

class AvaliaMoradorScreen extends StatefulWidget {
  final Map<String, dynamic> morador;
  AvaliaMoradorScreen({required this.morador});

  @override
  _AvaliaMoradorScreenState createState() => _AvaliaMoradorScreenState();
}

class _AvaliaMoradorScreenState extends State<AvaliaMoradorScreen> {
  final TextEditingController _comentarioController = TextEditingController();
  String errorMessage = '';


  final _formKey = GlobalKey<FormState>();
  String? _id;
  String nomeUsuarioAvaliado = '';
  double _organizacao = 0;
  double _convivencia = 0;
  double _festivo = 0;
  double _responsavel = 0;

  @override
  void initState() {
    super.initState();
    _id = widget.morador['id'];
    _fetchNomeUsuarioAvaliado();
  }

  void _fetchNomeUsuarioAvaliado() async {
    final usuarioAvaliadoDoc = await FirebaseFirestore.instance.collection('moradores').doc(_id).get();
    if (usuarioAvaliadoDoc.exists && usuarioAvaliadoDoc.data() != null) {
      setState(() {
        nomeUsuarioAvaliado = usuarioAvaliadoDoc.data()!['nome'];
      });
    }
  }

  void _registerNewAvaliacao() async {
    setState(() {
      errorMessage = '';
    });

    Morador? moradorUsuario = Provider.of<MoradorProvider>(context, listen: false).morador;

    if (moradorUsuario == null) {
      setState(() {
        errorMessage = 'Usuário não identificado. Por favor, faça login novamente.';
      });
      return;
    }

    AvaliacaoMorador newAvaliacao = AvaliacaoMorador(
      organizacao: _organizacao,
      convivencia: _convivencia,
      festivo: _festivo,
      responsavel: _responsavel,
      autorId: moradorUsuario.id!,
      moradorId: _id!,
      estrela: (_organizacao + _convivencia + _festivo + _responsavel)/4.0,
      comentario: _comentarioController.text
    );

    try {
      CollectionReference avaliacaoCollection =
        FirebaseFirestore.instance.collection('avaliacoesMoradores');
      
      String generatedAvaliacaoId = avaliacaoCollection.doc().id;
      newAvaliacao.id = generatedAvaliacaoId;

      await avaliacaoCollection
          .doc(generatedAvaliacaoId)
          .set(newAvaliacao.toMap());

      await FirebaseFirestore.instance
        .collection('moradores')
        .doc(_id)
        .update({
          'avaliacoesId': FieldValue.arrayUnion([newAvaliacao.id!])
        });

      Navigator.of(context).pushReplacementNamed('/mostraMoradoresScreen');
    } catch (e) {
      print("Erro ao salvar avaliação: $e");
    }
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliar Morador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${nomeUsuarioAvaliado}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF497A9D),
                ),
              ),
              SizedBox(height: 16.0),
              _buildRatingBar('Organização', _organizacao, (value) {
                setState(() {
                  _organizacao = value;
                });
              }),
              _buildRatingBar('Convivência', _convivencia, (value) {
                setState(() {
                  _convivencia = value;
                });
              }),
              _buildRatingBar('Festivo', _festivo, (value) {
                setState(() {
                  _festivo = value;
                });
              }),
              _buildRatingBar('Responsável', _responsavel, (value) {
                setState(() {
                  _responsavel = value;
                });
              }),
              TextFormField(
                  controller: _comentarioController,
                  decoration: InputDecoration(labelText: 'Comentário'),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(280),
                  ],
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _registerNewAvaliacao();
                      }
                    },
                    child: Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label),
        RatingBar.builder(
          initialRating: value,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: onChanged,
        ),
      ],
    );
  }
}
