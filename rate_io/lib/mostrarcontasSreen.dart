import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/moradorProvider.dart';

class MostrarDespesasScreen extends StatefulWidget {
  final Map<String, dynamic> rep;
  MostrarDespesasScreen({required this.rep});

  @override
  _MostrarDespesasScreenState createState() => _MostrarDespesasScreenState();
}

class _MostrarDespesasScreenState extends State<MostrarDespesasScreen> {
  List<Map<String, dynamic>> _despesas = [];

  @override
  void initState() {
    _fetchDespesas();
    super.initState();
  }

  Future<void> _fetchDespesas() async {
    final meuPerfil =
        Provider.of<MoradorProvider>(context, listen: false).morador;
    print('perfil morador ${meuPerfil?.id}');
    try {
      // Consulta todas as despesas diretamente com o filtro pelo morador
      final despesasQuery = await FirebaseFirestore.instance
          .collection('despesa')
          .where('morador', isEqualTo: meuPerfil?.id)
          .get();

// Verificando se a consulta retornou algum documento
      if (despesasQuery.docs.isNotEmpty) {
        // Iterando sobre os documentos retornados e imprimindo os dados
        for (var doc in despesasQuery.docs) {
          print('ID: ${doc.id}');
          print('Dados: ${doc.data()}');
        }
      } else {
        print('Nenhuma despesa encontrada para o morador.');
      }

      // Converte os documentos em uma lista de Map
      final results = despesasQuery.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Adiciona o ID do documento
        return data;
      }).toList();
      print(results);
      setState(() {
        _despesas = results;
      });
      await fetchAutores();
    } catch (e) {
      print('Erro ao buscar despesas: $e');
    }
  }

  Future<void> fetchAutores() async {
    for (var despesa in _despesas) {
      final autorDoc = await FirebaseFirestore.instance
          .collection('moradores')
          .doc(despesa['autorId'])
          .get();
      if (autorDoc.exists) {
        setState(() {
          despesa['autorNome'] =
              autorDoc.data()?['nome'] ?? 'Autor desconhecido';
        });
      }
    }
  }

  Future<void> _excluirDespesa(String id) async {
    try {
      await FirebaseFirestore.instance.collection('despesas').doc(id).delete();
      setState(() {
        _despesas.removeWhere((despesa) => despesa['id'] == id);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Despesa excluída com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir a despesa: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meuPerfil = Provider.of<MoradorProvider>(context).morador;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas de ${meuPerfil?.nome}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF497A9D),
          ),
        ),
      ),
      body: _despesas.isEmpty
          ? Center(child: Text('Nenhuma despesa encontrada'))
          : ListView.builder(
              itemCount: _despesas.length,
              itemBuilder: (context, index) {
                final despesa = _despesas[index];
                return ListTile(
                  title: Text('Autor: ${meuPerfil?.nome ?? 'Desconhecido'}'),
                  subtitle:
                      Text('Valor: R\$${despesa['valorTotal'] ?? '0.00'}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      if (despesa['morador'] == meuPerfil?.id) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Excluir Despesa'),
                              content: Text(
                                  'Tem certeza de que deseja excluir esta despesa?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    await _excluirDespesa(despesa['id']);
                                  },
                                  child: Text(
                                    'Excluir',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Você não pode excluir esta despesa.')),
                        );
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
