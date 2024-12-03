import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rate_io/classes/sexo.dart';
import 'routes.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  final Map<String, dynamic> morador;
  PerfilUsuarioScreen({required this.morador});

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuarioScreen> {
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
          print(nomeRep);
          return Padding(
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
                        Navigator.of(context).pushNamed(Routes.editarPerfilMoradorScreen); //////MUDAR PARA A TELA DE CONVIDAR
                      },
                      child: Text('Convidar'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}