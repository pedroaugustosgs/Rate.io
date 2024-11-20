import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/avaliaRep.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';


class AvaliaRepScreen extends StatefulWidget {
  @override
  _AvaliaRepScreenState createState() => _AvaliaRepScreenState();
}

class _AvaliaRepScreenState extends State<AvaliaRepScreen> {
  final TextEditingController _comentarioController = TextEditingController();
  String errorMessage = '';

  double _pinga = 0;
  double _sossego = 0;
  double _limpeza = 0;
  double _resenha = 0;
  double _custo = 0;
  
  void _registerNewAvaliacao() async {
    setState(() {
      errorMessage = '';
    });

    Morador? moradorUsuario = Provider.of<MoradorProvider>(context, listen: false).morador;
    Rep? repUsuario = Provider.of<RepProvider>(context, listen: false).rep;


    if (moradorUsuario == null) {
      setState(() {
        errorMessage = 'Usuário não identificado. Por favor, faça login novamente.';
      });
      return;
    }
    if (repUsuario == null) {
      setState(() {
        errorMessage = 'Rep não identificada. Por favor, faça login novamente.';
      });
      return;
    }

    AvaliaRep newAvaliacao = AvaliaRep(
      pinga: _pinga,
      sossego: _sossego,
      limpeza: _limpeza,
      resenha: _resenha,
      custo: _custo,
      repId: repUsuario.id!,
      autorId: moradorUsuario.id!,
      estrela: (_pinga + _sossego + _limpeza + _resenha + _custo)/5.0,
      comentario: _comentarioController.text
    );

    try {
      CollectionReference avaliacaoCollection =
        FirebaseFirestore.instance.collection('avaliacoesRep');
      
      String generatedAvaliacaoId = avaliacaoCollection.doc().id;
      newAvaliacao.id = generatedAvaliacaoId;

      await avaliacaoCollection
          .doc(generatedAvaliacaoId)
          .set(newAvaliacao.toMap());


      repUsuario.avaliacoesId ??= [];
      repUsuario.avaliacoesId!.add(newAvaliacao.id!);

      await FirebaseFirestore.instance
          .collection('republicas')
          .doc(repUsuario.id)
          .update(repUsuario.toMap());

      Navigator.of(context).pushReplacementNamed('/homeScreen');
    } catch (e) {
      print("Erro ao salvar avaliação: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final repUsuario = Provider.of<RepProvider>(context).rep;

    return Scaffold(
      appBar: AppBar(
        title: Text('Avaliar República'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Olá, ${repUsuario!.nome}"),
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
                          _registerNewAvaliacao();
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              ],
            ),
          ],
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