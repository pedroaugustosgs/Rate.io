import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rate_io/classes/avaliaMorador.dart';
import 'models/avaliaMoradorModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvaliaMoradorScreen extends StatefulWidget {
  final Map<String, dynamic> morador;
  AvaliaMoradorScreen({required this.morador});

  @override
  _AvaliaMoradorScreenState createState() => _AvaliaMoradorScreenState();
}

class _AvaliaMoradorScreenState extends State<AvaliaMoradorScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  double _organizacao = 0;
  double _convivencia = 0;
  double _festivo = 0;
  double _responsavel = 0;
  double _estrelaInput = 0;
  String _comentarioInput = '';

  @override
  void initState() {
    super.initState();
    _id = widget.morador['id'];
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
              _buildRatingBar('Estrelas', _estrelaInput, (value) {
                setState(() {
                  _estrelaInput = value;
                });
              }),
              TextFormField(
                decoration: InputDecoration(labelText: 'Comentário'),
                onSaved: (value) {
                  _comentarioInput = value!;
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        // Enviar os dados para o backend ou processar de alguma forma
                        AvaliacaoMorador newAvaliacao = AvaliacaoMorador(
                          id: _id,
                          organizacao: _organizacao,
                          convivencia: _convivencia,
                          festivo: _festivo,
                          responsavel: _responsavel,
                        );
                        print(newAvaliacao);
                        FirebaseFirestore.instance.collection('moradores');
                        try {
                          // Obtenha o ID do usuário
                          _id;
                          CollectionReference usersCollection =
                              FirebaseFirestore.instance
                                  .collection('avaliacoesMoradores');

                          // Adicione o usuário na coleção do Firestore
                          usersCollection.doc().set(newAvaliacao
                              .toMap()); // Salve os dados do usuário
                          Navigator.of(context)
                              .pushReplacementNamed('/mostraMoradoresScreen');
                        } catch (e) {
                          print("Erro ao salvar avaliacao: $e");
                          // Você pode querer lidar com erros aqui
                        }
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
