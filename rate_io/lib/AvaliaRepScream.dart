import 'package:flutter/material.dart';

class AvaliaRepScreen extends StatefulWidget {
  @override
  _AvaliaRepScreenState createState() => _AvaliaRepScreenState();
}

class _AvaliaRepScreenState extends State<AvaliaRepScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _repName;
  int _pinga = 0;
  int _sossego = 0;
  int _limpeza = 0;
  int _resenha = 0;
  int _custo = 0;

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
              _buildSlider('Pinga', _pinga, (value) {
                setState(() {
                  _pinga = value;
                });
              }),
              _buildSlider('Sossego', _sossego, (value) {
                setState(() {
                  _sossego = value;
                });
              }),
              _buildSlider('Limpeza', _limpeza, (value) {
                setState(() {
                  _limpeza = value;
                });
              }),
              _buildSlider('Resenha', _resenha, (value) {
                setState(() {
                  _resenha = value;
                });
              }),
              _buildSlider('Custo', _custo, (value) {
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

  Widget _buildSlider(String label, int value, ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 5,
          divisions: 5,
          label: value.toString(),
          onChanged: (double newValue) {
            onChanged(newValue.toInt());
          },
        ),
      ],
    );
  }
}