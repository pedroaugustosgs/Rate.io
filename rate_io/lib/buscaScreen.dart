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

void _meuPerfil(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.perfilMorador);
  }

class _BuscaScreenState extends State<BuscaScreen> {
  int _currentIndex = 0;
  int _anteriorIndex = 1;
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
    //print(_buscaController.text);
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

  void buscaResultados() {
    List<Map<String, dynamic>> resultadosFiltrados = [];
    if (_buscaController.text.isNotEmpty) {
      for (var morador in _todosResultados) {
        final nome = morador['nome']?.toString().toLowerCase() ?? '';
        if (nome.contains(_buscaController.text.toLowerCase())) {
          resultadosFiltrados.add(morador);
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
          if (_currentIndex == index && _anteriorIndex == index) {
            return; // Se o botão clicado for igual ao referente à tela atual, nada acontece
          }
          setState(() {
            _anteriorIndex = _currentIndex;
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(
              context,
              Routes.buscaScreen,
              arguments: moradorUsuario,
            );
          } else if (index == 1) {
            Navigator.pushNamed(
              context,
              Routes.homeScreen,
            );
          } else if (index == 2) {
            Navigator.pushNamed(
              context,
              Routes.perfilMorador,
              arguments: moradorUsuario,
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
      ),
      appBar: AppBar(
        title: TextField(
          controller: _buscaController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: 'Busca'
          ),
        )
      ),
      body: _resultadoBusca.isEmpty
          ? Center(child: Text('Nenhum resultado encontrado'))
          : ListView.builder(
            itemCount: _resultadoBusca.length,
            itemBuilder: (context, index) {
              final perfil = _resultadoBusca[index];
              return ListTile(
                title: Text(_resultadoBusca[index]['nome'],),
                subtitle: Text(_resultadoBusca[index]['faculdade'],),
                trailing: IconButton(
                  icon: Icon(Icons.label_important_outline_sharp),
                  onPressed: () {
                    if(_resultadoBusca[index]['id'] == moradorUsuario?.id) {
                      _meuPerfil(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            _navigatePerfilUsuario(morador: perfil),
                        ),
                      );
                    }
                  },
                )
              );
            }
          ),
    );
  }
}