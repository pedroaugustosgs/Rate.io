import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/perfilUsuarioScreen.dart';
import 'package:rate_io/routes.dart';

class BuscaScreen extends StatefulWidget {
  @override
  _BuscaScreenState createState() => _BuscaScreenState();
}

Widget _navigatePerfilUsuario({required Map<String, dynamic> morador}) {
  return PerfilUsuarioScreen(morador: morador);
}

class _BuscaScreenState extends State<BuscaScreen> {
  bool _buscaRep = false; 
  int _currentIndex = 0; 
  List<Map<String, dynamic>> _todosResultados = []; 
  List<Map<String, dynamic>> _resultadoBusca = []; 
  final TextEditingController _buscaController = TextEditingController();

  @override
  void initState() {
    _buscaController.addListener(_onSearchChanged);
    _fetchUsuarios(); 
    super.initState();
  }

  _onSearchChanged() {
    buscaResultados(); 
  }

  Future<void> _fetchUsuarios() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('moradores').orderBy('nome').get();
      final results = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      setState(() {
        _todosResultados = results;
      });
      buscaResultados();
    } catch (e) {
      print('Erro ao buscar usuários: $e');
    }
  }

  Future<void> _fetchRepublicas() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('republicas').orderBy('nome').get();
      final results = querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      setState(() {
        _todosResultados = results;
      });
      buscaResultados();
    } catch (e) {
      print('Erro ao buscar repúblicas: $e');
    }
  }

  void buscaResultados() {
    List<Map<String, dynamic>> resultadosFiltrados = [];
    if (_buscaController.text.isNotEmpty) {
      for (var buscado in _todosResultados) {
        final nome = buscado['nome']?.toString().toLowerCase() ?? '';
        if (nome.contains(_buscaController.text.toLowerCase())) {
          resultadosFiltrados.add(buscado);
        }
      }
    } else {
      resultadosFiltrados = List.from(_todosResultados);
    }

    setState(() {
      _resultadoBusca = resultadosFiltrados;
    });
  }

  @override
  void dispose() {
    _buscaController.removeListener(_onSearchChanged);
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moradorUsuario = Provider.of<MoradorProvider>(context).morador;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex == index) return; 
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushReplacementNamed(context, Routes.buscaScreen);
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, Routes.homeScreen);
          } else if (index == 2 && moradorUsuario != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _navigatePerfilUsuario(morador: moradorUsuario.toMap()),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      appBar: AppBar(
        title: TextField(
          controller: _buscaController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Busca',
          ),
        ),
      ),
      body: Column(
        children: [
          ToggleButtons(
            isSelected: [_buscaRep, !_buscaRep],
            onPressed: (index) {
              setState(() {
                _buscaRep = index == 0; 
              });
              if (_buscaRep) {
                _fetchRepublicas(); 
              } else {
                _fetchUsuarios(); 
              }
            },
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Repúblicas'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Usuários do app'),
              ),
            ],
          ),
          Expanded(
            child: _resultadoBusca.isEmpty
                ? Center(child: Text('Nenhum resultado encontrado'))
                : ListView.builder(
                    itemCount: _resultadoBusca.length,
                    itemBuilder: (context, index) {
                      final perfil = _resultadoBusca[index];
                      return ListTile(
                        title: Text(perfil['nome']), 
                        subtitle: perfil.containsKey('faculdade')
                            ? Text(perfil['faculdade']) 
                            : null, 
                        trailing: IconButton(
                          icon: Icon(Icons.label_important_outline_sharp),
                          onPressed: () {
                            if (_buscaRep) {
                              Navigator.pushNamed(
                                context,
                                Routes.PerfilrepScreen,
                                arguments: perfil, 
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => _navigatePerfilUsuario(
                                    morador: perfil, 
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
