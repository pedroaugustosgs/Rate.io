import 'package:flutter/material.dart';
import 'classes/morador.dart';
import 'routes.dart';

class PerfilMorador extends StatefulWidget {
  

  PerfilMorador();

  @override
  _PerfilMoradorState createState() => _PerfilMoradorState();
}

class _PerfilMoradorState extends State<PerfilMorador> {
  late TextEditingController _telefoneController;
  late TextEditingController _cursoController;
  late TextEditingController _faculdadeController;
  late TextEditingController _idadeController;

  @override
  void initState() {
    super.initState();
    _telefoneController = TextEditingController();
    _cursoController = TextEditingController();
    _faculdadeController = TextEditingController();
    _idadeController = TextEditingController();
  }

  @override
  void dispose() {
    _telefoneController.dispose();
    _cursoController.dispose();
    _faculdadeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  void _salvarAlteracoes() {
    // Modelo de função para salvar os valores alterados
    // Aqui você pode adicionar a lógica para salvar os dados no banco
  }

  void _preencherCamposComBanco() {
    // Modelo de função para preencher os campos com dados do banco
    // Aqui você pode adicionar a lógica para buscar os dados do banco e preencher os campos
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Morador'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ', style: TextStyle(fontSize: 24)),
            Text('Email: ', style: TextStyle(fontSize: 24)),
            Text('Sexo: ', style: TextStyle(fontSize: 24)),
            Text('Rep: ', style: TextStyle(fontSize: 24)),
            Text('Telefone: ', style: TextStyle(fontSize: 24)),
            Text('Curso: ', style: TextStyle(fontSize: 24)),
            Text('Faculdade: ', style: TextStyle(fontSize: 24)),
            Text('Idade: ', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Voltar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navegar para a tela de avaliações
                  },
                  child: Text('Avaliações'),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(Routes.editarPerfilMoradorScreen);
                  },
                  child: Text('Editar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}