import 'package:flutter/material.dart';

class AvaliaMoradorScreen extends StatefulWidget {
  @override
  _AvaliaMoradorScreenState createState() => _AvaliaMoradorScreenState();
}

class _AvaliaMoradorScreenState extends State<AvaliaMoradorScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _id;
  int _organizacao = 0;
  int _convivencia = 0;
  int _festivo = 0;
  int _responsavel = 0;
  int _estrelaInput = 0;
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
              _buildSlider('Organização', _organizacao, (value) {
                setState(() {
                  _organizacao = value;
                });
              }),
              _buildSlider('Convivência', _convivencia, (value) {
                setState(() {
                  _convivencia = value;
                });
              }),
              _buildSlider('Festivo', _festivo, (value) {
                setState(() {
                  _festivo = value;
                });
              }),
              _buildSlider('Responsável', _responsavel, (value) {
                setState(() {
                  _responsavel = value;
                });
              }),
              _buildSlider('Estrelas', _estrelaInput, (value) {
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