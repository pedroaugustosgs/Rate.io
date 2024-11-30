import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_io/perfilUsuarioScreen.dart';

class BuscaScreen extends StatefulWidget {
  @override
  _BuscaScreenState createState() => _BuscaScreenState();
}

Widget _navigatePerfilUsuario({required Map<String, dynamic> morador}) {
  return PerfilUsuarioScreen(morador: morador);
}

class _BuscaScreenState extends State<BuscaScreen> {

  List<Map<String, dynamic>> _todosResultados = [];
  List<Map<String, dynamic>> _resultadoBusca = [];
  final TextEditingController _buscaController = TextEditingController();


  @override
  void initState() {
    _buscaController.addListener(_onSearchChanged);
    _fetchMoradores();
    super.initState();
  }

  _onSearchChanged() {
    //print(_buscaController.text);
    buscaResultados();
  }

  Future<void> _fetchMoradores() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('moradores').orderBy('nome').get();
      final results = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Add the document ID to the data
        return data;
      }).toList();

      setState(() {
        _todosResultados = results;
      });
      buscaResultados();
    } catch (e) {
      print('Erro ao buscar moradores: $e');
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
    return Scaffold(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          _navigatePerfilUsuario(morador: perfil),
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