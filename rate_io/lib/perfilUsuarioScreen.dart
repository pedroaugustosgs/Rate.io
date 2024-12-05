import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/AtribuirTarefaScreen.dart';
import 'package:rate_io/avaliaMoradorScreen.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'package:rate_io/convidarUsuarioScreen.dart';
import 'package:rate_io/routes.dart';
import 'package:rate_io/verAvaliacoesScreen.dart';
import 'package:rate_io/classes/sexo.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  final Map<String, dynamic> morador;
  PerfilUsuarioScreen({required this.morador});

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuarioScreen> {
  int _currentIndex = 1;
  int _anteriorIndex = 0;
  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.morador['id'];
  }

  Future<Map<String, dynamic>> _fetchUsuarioERep() async {
    try {
      final usuarioDoc = await FirebaseFirestore.instance.collection('moradores').doc(_id).get();
      if (!usuarioDoc.exists || usuarioDoc.data() == null) {
        throw Exception('Morador não encontrado.');
      }
      final moradorData = usuarioDoc.data()!;

      String? repId = moradorData['repId'];
      String? nomeRep;
      print(repId);
      if (repId != null && repId.isNotEmpty) {
        final republicDoc = await FirebaseFirestore.instance.collection('republicas').doc(repId).get();
        nomeRep = republicDoc.data()?['nome'] ?? 'República não encontrada';
      }
      print(nomeRep);
      return {
        'morador': moradorData,
        'nomeRep': nomeRep,
      };
    } catch (e) {
      throw Exception('Erro ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final meuPerfil = Provider.of<MoradorProvider>(context).morador;
    final minhaRep = Provider.of<RepProvider>(context).rep;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchUsuarioERep(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Dados não encontrados'));
          }

          final usuario = snapshot.data!['morador'] as Map<String, dynamic>;
          final nomeRep = snapshot.data!['nomeRep'] as String?;

          return Scaffold(
            bottomNavigationBar: (usuario['id'] == meuPerfil!.id)
                ? BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      if (_currentIndex == index && _anteriorIndex == index) {
                        return;
                      }
                      setState(() {
                        _anteriorIndex = _currentIndex;
                        _currentIndex = index;
                      });
                      if (index == 0) {
                        Navigator.pushNamed(
                          context,
                          Routes.buscaScreen,
                          arguments: meuPerfil,
                        );
                      } else if (index == 1) {
                        Navigator.pushNamed(
                          context,
                          Routes.homeScreen,
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PerfilUsuarioScreen(morador: meuPerfil.toMap()),
                          ),
                        );
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_balance),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: '',
                      ),
                    ],
                  )
                : null,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome: ${usuario['nome']}', style: TextStyle(fontSize: 24)),
                  Text('Sexo: ${SexoExtension.fromString(usuario['sexo']).name}', style: TextStyle(fontSize: 24)),
                  Text('Rep: ${nomeRep ?? 'Sem república'}', style: TextStyle(fontSize: 24)),
                  Text('Telefone: ${usuario['telefone']}', style: TextStyle(fontSize: 24)),
                  Text('Curso: ${usuario['curso']}', style: TextStyle(fontSize: 24)),
                  Text('Faculdade: ${usuario['faculdade']}', style: TextStyle(fontSize: 24)),
                  Text('Data de nascimento: ${DateFormat('dd/MM/yyyy').format((usuario['dataNascimento'] as Timestamp).toDate())}', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Voltar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerAvaliacoesScreen(usuario: usuario),
                            ),
                          );
                        },
                        child: Text('Avaliações'),
                      ),
                      if (usuario['id'] == meuPerfil.id) ...[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.editarPerfilMoradorScreen);
                          },
                          child: Text('Editar meu perfil'),
                        ),
                      ] else ...[
                        if (usuario['repId'] == null && meuPerfil.id == minhaRep!.moradorADMId)
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ConvidarUsuarioScreen(usuario: usuario),
                                ),
                              );
                            },
                            child: Text('Convidar'),
                          ),
                        if (usuario['repId'] == meuPerfil.repId) ...[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AvaliaMoradorScreen(morador: usuario),
                                ),
                              );
                            },
                            child: Text('Avaliar'),
                          ),
                          if (meuPerfil.id == minhaRep!.moradorADMId)
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AtribuirTarefaScreen(morador: usuario),
                                  ),
                                );
                              },
                              child: Text('Atribuir Tarefa'),
                            ),
                        ],
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}