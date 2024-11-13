import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class AvaliaRepScreen extends StatefulWidget {
  @override
  _AvaliaRepScreenState createState() => _AvaliaRepScreenState();
}

class _AvaliaRepScreenState extends State<AvaliaRepScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _repName;
  double _pinga = 0;
  double _sossego = 0;
  double _limpeza = 0;
  double _resenha = 0;
  double _custo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliar República'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome da República'),
                onSaved: (value) {
                  _repName = value;
                },
              ),
              SizedBox(height: 16.0),
              _buildRatingBar('Pinga', _pinga, (value) {
                setState(() {
                  _pinga = value;
                });
              }),
              _buildRatingBar('Sossego', _sossego, (value) {
                setState(() {
                  _sossego = value;
                });
              }),
              _buildRatingBar('Limpeza', _limpeza, (value) {
                setState(() {
                  _limpeza = value;
                });
              }),
              _buildRatingBar('Resenha', _resenha, (value) {
                setState(() {
                  _resenha = value;
                });
              }),
              _buildRatingBar('Custo', _custo, (value) {
                setState(() {
                  _custo = value;
                });
              }),
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
                        // Enviar os dados pro banco - não implementado
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