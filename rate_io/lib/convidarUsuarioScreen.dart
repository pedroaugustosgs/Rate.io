import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/convite.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';

class ConvidarUsuarioScreen extends StatefulWidget {
  final Map<String, dynamic> usuario;
  ConvidarUsuarioScreen({required this.usuario});
  @override
  _ConvidarUsuarioScreen createState() => _ConvidarUsuarioScreen();
}

class _ConvidarUsuarioScreen extends State<ConvidarUsuarioScreen> {
  late String _id;
  final TextEditingController _descricaoController = TextEditingController();

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _id = widget.usuario['id'];
  }

  void _registrarConvite() async {
    Rep? repUsuario = Provider.of<RepProvider>(context, listen: false).rep;

    if (repUsuario == null) {
      setState(() {
        errorMessage = 'Você deve estar em uma república para convidar alguém';
      });
      return;
    }

    String descricao = _descricaoController.text.isEmpty
      ? 'Queremos você na nossa república!'
      : _descricaoController.text;

    Convite newConvite = Convite(
      repId: repUsuario.id!,
      descricao: descricao    
    );

    try {
      CollectionReference eventoCollection =
        FirebaseFirestore.instance.collection('convites');
      
      String generatedConviteId = eventoCollection.doc().id;
      newConvite.id = generatedConviteId;

      await eventoCollection
          .doc(generatedConviteId)
          .set(newConvite.toMap());

      await FirebaseFirestore.instance
        .collection('moradores')
        .doc(_id)
        .update({
          'convitesId': FieldValue.arrayUnion([newConvite.id])
        });

    } catch (e) {
      print("Erro ao salvar convite: $e");
    }

  }

  @override
  Widget build(BuildContext context) {
    Rep? repUsuario = Provider.of<RepProvider>(context).rep;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Convidar ${widget.usuario['nome']} para ${repUsuario!.nome}',
          style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF497A9D),
                ),
          ),
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
                controller: _descricaoController,
                decoration: InputDecoration( 
                  labelText: 'Mensagem',
                  hintText: 'Queremos você na nossa república!'
                ),
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
                      _registrarConvite();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Convite enviado com sucesso!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Convidar'),
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