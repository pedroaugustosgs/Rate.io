import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AvaliaMoradorScreen extends StatefulWidget {
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
              TextFormField(
                decoration: InputDecoration(labelText: 'ID do Morador'),
                onSaved: (value) {
                  _id = value;
                },
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

  Widget _buildRatingBar(String label, double value, ValueChanged<double> onChanged) {
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