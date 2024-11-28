import 'package:flutter/material.dart';
import 'package:rate_io/classes/morador.dart';
import 'classes/rep.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'avaliaMoradorScreen.dart';
import 'routes.dart';

Widget _navigateAvaliaMorador({required Map<String, dynamic> morador}) {
  return AvaliaMoradorScreen(morador: morador);
}

class MostraMoradoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tenta receber o argumento (Rep) da navegação
    final Rep? rep = ModalRoute.of(context)!.settings.arguments as Rep?;

    print('rep ${rep}');
    // Verifique se o 'rep' não é null
    if (rep == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Erro')),
        body: Center(child: Text('Rep não encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Moradores da República ${rep.nome}'),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment
              .end, // Alinha o texto na parte inferior da AppBar
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Clique para abrir perfil',
                // style: TextStyle(
                //   color: Colors.white,
                //   fontSize: 16,
                //   fontStyle: FontStyle.italic,
                // ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: rep.id != null ? _buscarMoradores(rep.id!) : Future.value([]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar moradores'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Center(child: Text('Nenhum morador encontrado'));
          }

          final moradores = snapshot.data as List;
          return ListView.builder(
            itemCount: moradores.length,
            itemBuilder: (context, index) {
              final morador = moradores[index];
              print(morador); // Aqui você já verifica os dados de cada morador
              return InkWell(
                // Certifique-se de retornar o InkWell
                onTap: () {
                  if (morador != null) {
                    // Navega para a tela de avaliação, passando o morador
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            _navigateAvaliaMorador(morador: morador),
                      ),
                    );
                  } else {
                    // Caso o morador não tenha sido selecionado
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Nenhum morador selecionado!')),
                    );
                  }
                },
                child: ListTile(
                  title: Text(morador['nome']),
                  subtitle: Text(morador['email']),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _buscarMoradores(String repId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('moradores')
        .where('repId', isEqualTo: repId)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}
