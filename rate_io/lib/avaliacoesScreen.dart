import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AvaliacoesScreen extends StatefulWidget {
  final Map<String, dynamic> usuario;
  AvaliacoesScreen({required this.usuario});

  @override
  _AvaliacoesScreenState createState() => _AvaliacoesScreenState();
}

class _AvaliacoesScreenState extends State<AvaliacoesScreen> {
  List<Map<String, dynamic>> _avaliacoes = [];

  @override
  void initState() {
    _fetchAvaliacoes();
    super.initState();
  }

  Future<void> _fetchAvaliacoes() async {
    try {
      final usuarioDoc = await FirebaseFirestore.instance.collection('moradores').doc(widget.usuario['id']).get();
      final avaliacaoIds = List<String>.from(usuarioDoc.data()?['avaliacoesId'] ?? []);
      
      List<Map<String, dynamic>> results = [];
      for (String id in avaliacaoIds) {
        final avaliacaoDoc = await FirebaseFirestore.instance.collection('avaliacoesMoradores').doc(id).get();
        if (avaliacaoDoc.exists) {
          final data = avaliacaoDoc.data()!;
          data['id'] = avaliacaoDoc.id;
          results.add(data);
        }
      }

        setState(() {
          _avaliacoes = results;
        });
        await _fetchNomeAutores();
    } catch (e) {
      print('Erro ao buscar avaliações: $e');
    }
  }

  Future<void> _fetchNomeAutores() async {
    for (var avaliacao in _avaliacoes) {
      final autorDoc = await FirebaseFirestore.instance.collection('moradores').doc(avaliacao['autorId']).get();
      if (autorDoc.exists) {
        setState(() {
          avaliacao['autorNome'] = autorDoc.data()?['nome'] ?? 'Autor desconhecido';
        });
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Avaliações de ${widget.usuario['nome']}',
          style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF497A9D),
                ),
          ),
      ),
      body: _avaliacoes.isEmpty
          ? Center(child: Text('Nenhum avaliação encontrada'))
          : ListView.builder(
            itemCount: _avaliacoes.length,
            itemBuilder: (context, index) {
              final avaliacao = _avaliacoes[index];
              return ListTile(
                title: Text('Autor: ${avaliacao['autorNome'] ?? ' desconhecido'}'),
                subtitle: Row(
                  children: [
                    Text('Média: '),
                    RatingBarIndicator(
                      rating: avaliacao['estrela'] ?? 0.0,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 20.0,
                    ),
                  ],
                ), 
                trailing: IconButton(
                  icon: Icon(Icons.label_important_outline_sharp),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Avaliação'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildRatingRow('Organização', avaliacao['organizacao'] ?? 0.0),
                            _buildRatingRow('Convivência', avaliacao['convivencia'] ?? 0.0),
                            _buildRatingRow('Festivo', avaliacao['festivo'] ?? 0.0),
                            _buildRatingRow('Responsável', avaliacao['responsavel'] ?? 0.0),
                            SizedBox(height: 16.0),
                            Text('Comentário:'),
                            Text(avaliacao['comentario'] ?? 'Sem comentário'),
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
  Widget _buildRatingRow(String label, double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemSize: 20.0,
        ),
      ],
    );
  }
}
