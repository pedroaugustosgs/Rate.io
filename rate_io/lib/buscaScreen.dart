import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscaScreen extends StatefulWidget {
  @override
  _BuscaScreenState createState() => _BuscaScreenState();
}

class _BuscaScreenState extends State<BuscaScreen> {

  List _todosResultados = [];
  List _resultadoBusca = [];
  final TextEditingController _buscaController = TextEditingController();


  @override
  void initState() {
    _buscaController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    //print(_buscaController.text);
    buscaResultados();
  }

  buscaResultados() {
    var mostraResultados = [];
    if(_buscaController.text != "")
    {
      for(var clientSnapshot in _todosResultados)
      {
        var nome = clientSnapshot['nome'].toString().toLowerCase();
        if(nome.contains(_buscaController.text.toLowerCase()))
        {
          mostraResultados.add(clientSnapshot);
        }
      }
    } else {
      mostraResultados = List.from(_todosResultados);
    }

    setState(() {
      _resultadoBusca = mostraResultados;
    });
  }

  getClientStream() async {
    var data = await FirebaseFirestore.instance.collection('moradores').orderBy('nome').get();

    setState(() {
      _todosResultados = data.docs;
    });
    buscaResultados();
  }

  

  @override
  void dispose() {
    _buscaController.removeListener(_onSearchChanged);
    _buscaController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
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
      body: ListView.builder(
        itemCount: _resultadoBusca.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_resultadoBusca[index]['nome'],),
            subtitle: Text(_resultadoBusca[index]['faculdade'],),
            trailing: Text(_resultadoBusca[index]['email'],),
          );
        }
      ),
    );
  }
}