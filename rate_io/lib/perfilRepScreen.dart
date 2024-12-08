import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/verAvaliacoesRepScreen.dart';
import 'routes.dart';

class PerfilRepScreen extends StatefulWidget {
  final Map<String, dynamic> rep;
  PerfilRepScreen({required this.rep});

  @override
  _PerfilRepScreen createState() => _PerfilRepScreen();
}

class _PerfilRepScreen extends State<PerfilRepScreen> {
  late String _id;

  @override
  void initState() {
    super.initState();
    _id = widget.rep['id'];
  }

  Future<Map<String, dynamic>> _fetchRepEADM() async {
    try {
      final repDoc = await FirebaseFirestore.instance.collection('republicas').doc(_id).get();
      if (!repDoc.exists || repDoc.data() == null) {
        throw Exception('República não encontrada.');
      }
      final repData = repDoc.data()!;

      final numeroMoradores = await FirebaseFirestore.instance
        .collection('moradores')
        .where('repId', isEqualTo: repData['id'])
        .get();
      
      String? moradorADMId = repData['moradorADMId'];
      String? nomeADM;
      if (moradorADMId != null && moradorADMId.isNotEmpty) {
        final admDoc = await FirebaseFirestore.instance.collection('moradores').doc(moradorADMId).get();
        nomeADM = admDoc.data()?['nome'] ?? 'ADM não encontrado';
      }
      return {
        'rep': repData,
        'nomeADM': nomeADM,
        'numeroMoradores': numeroMoradores.size
      };
    } catch (e) {
      throw Exception('Erro ao carregar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final meuPerfil = Provider.of<MoradorProvider>(context).morador;

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil da Rep'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchRepEADM(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar dados'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Dados não encontrados'));
          }

          final rep = snapshot.data!['rep'] as Map<String, dynamic>;
          final nomeADM = snapshot.data!['nomeADM'] as String?;
          final numeroMoradores = snapshot.data!['numeroMoradores'] as int;

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nome: ${rep['nome']}', style: TextStyle(fontSize: 24)),
                  Text('Tipo: ${rep['tipoSexo']}', style: TextStyle(fontSize: 24)),
                  Text('ADM: ${nomeADM ?? ''}', style: TextStyle(fontSize: 24)),
                  Text('Endereço: ${rep['endereco']}', style: TextStyle(fontSize: 24)),
                  Text('Lotação: ${numeroMoradores}/${rep['lotacao']}', style: TextStyle(fontSize: 24)),
                  Text('Ano de Fundação: ${DateFormat('yyyy').format((rep['anoFundacao'] as Timestamp).toDate())}', style: TextStyle(fontSize: 24)),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Voltar'),
                      ),
                      if (rep['id'] != meuPerfil?.repId) ...[
                        ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed(
                              Routes.mostraMoradoresScreen,
                              arguments: Rep.fromMap(rep),
                            );
                          },
                          child: Text('Moradores')
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerAvaliacoesRepScreen(rep: rep),
                              ),
                            );
                          },
                          child: Text('Avaliações'),
                        ),
                      ] else ...[
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.homeScreen);
                          },
                          child: Text('Minha Rep'),
                        ),
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