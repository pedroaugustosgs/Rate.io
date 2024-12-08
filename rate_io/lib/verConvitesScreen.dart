import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/moradorProvider.dart';

class VerConvitesScreen extends StatefulWidget {
  @override
  _VerConvitesScreenState createState() => _VerConvitesScreenState();
}

class _VerConvitesScreenState extends State<VerConvitesScreen> {
  List<Map<String, dynamic>> _convites = [];

  @override
  void initState() {
    _fetchConvites();
    super.initState();
  }

  Future<void> _fetchConvites() async {
    Morador? meuPerfil = Provider.of<MoradorProvider>(context, listen: false).morador;

    try {
      final meuPerfilDoc = await FirebaseFirestore.instance.collection('moradores').doc(meuPerfil!.id).get();
      final convitesId = List<String>.from(meuPerfilDoc.data()?['convitesId'] ?? []);
      
      List<Map<String, dynamic>> results = [];
      for (String id in convitesId) {
        final conviteDoc = await FirebaseFirestore.instance.collection('convites').doc(id).get();
        if (conviteDoc.exists) {
          final data = conviteDoc.data()!;
          data['id'] = conviteDoc.id;
          results.add(data);
        }
      }

      setState(() {
        _convites = results;
      });
      await _fetchNomeReps();
    } catch (e) {
      print('Erro ao buscar convites: $e');
    }
  }

  Future<void> _fetchNomeReps() async {
    for (var convite in _convites) {
      final autorDoc = await FirebaseFirestore.instance.collection('republicas').doc(convite['repId']).get();
      if (autorDoc.exists) {
        setState(() {
          convite['repNome'] = autorDoc.data()?['nome'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Convites para você',
          style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF497A9D),
                ),
          ),
      ),
      body: _convites.isEmpty
          ? Center(child: Text('Nenhum convite encontrado'))
          : ListView.builder(
            itemCount: _convites.length,
            itemBuilder: (context, index) {
              final convite = _convites[index];
              return ListTile(
                title: Text('Rep: ${convite['repNome'] ?? ''}'), 
                trailing: IconButton(
                  icon: Icon(Icons.label_important_outline_sharp),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Convite'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Comentário:'),
                            Text(convite['descricao'] ?? ''),
                          ],
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Fechar',
                              style: TextStyle(
                                color: Color(0xFF497A9D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              );
            }
          ),
    );
  }
}