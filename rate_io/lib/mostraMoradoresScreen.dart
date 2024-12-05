import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:rate_io/perfilUsuarioScreen.dart';
import 'package:rate_io/routes.dart';
import 'classes/rep.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'avaliaMoradorScreen.dart';
import 'classes/repProvider.dart';
/*
Widget _navigateAvaliaMorador({required Map<String, dynamic> morador}) {
  return AvaliaMoradorScreen(morador: morador);
}
*/
Widget _navigatePerfilUsuario({required Map<String, dynamic> morador}) {
  return PerfilUsuarioScreen(morador: morador);
}


void _meuPerfil(BuildContext context) async {
  await Navigator.of(context).pushNamed(Routes.perfilMorador);
}

class MostraMoradoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Tenta receber o argumento (Rep) da navegação
    Rep? rep = ModalRoute.of(context)!.settings.arguments as Rep?;

    print('rep ${rep}');

    if (rep == null) {
      Rep? repUsuario = Provider.of<RepProvider>(context).rep;
      rep = repUsuario;
    }
    final moradorUsuario = Provider.of<MoradorProvider>(context).morador;


    if (rep == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Erro')),
        body: Center(child: Text('Rep não encontrado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Moradores de ${rep.nome}'),
        flexibleSpace: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Alinha o texto na parte inferior da AppBar
          crossAxisAlignment: CrossAxisAlignment.start,
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
              print(morador); 
              return ListTile(
                title: Text(morador['nome'],),
                subtitle: Text(morador['email'],),
                trailing: IconButton(
                  icon: Icon(Icons.label_important_outline_sharp),
                  onPressed: () {
                    if(morador['id'] == moradorUsuario?.id) {
                      _meuPerfil(context);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            _navigatePerfilUsuario(morador: morador),
                        ),
                      );
                    }
                  },
                )
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
