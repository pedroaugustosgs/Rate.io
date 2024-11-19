import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'package:rate_io/models/repModel.dart';
import 'routes.dart';

Future<void> navigateToHomeScream(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/homeScreen');
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  void _registerRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.repRegisterScreen);
  }
  bool _isInit = true;

  Future<void> fetchAndSetRep(BuildContext context, String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = 
          await FirebaseFirestore.instance.collection('republicas').doc(uid).get();

      if (snapshot.exists) {
        print('Dados da república: ${snapshot.data()}');
        Rep rep = Rep.fromMap(snapshot.data()!);

        // Set user in the provider
        print("Setting user in provider...");
        Provider.of<RepProvider>(context, listen: false).setUser(rep);
        print("User set in provider: ${rep.nome}");

      } else {
        print("User document does not exist.");
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_isInit) {
      final moradorUsuario = Provider.of<MoradorProvider>(context).morador;
      if(moradorUsuario?.repId != null) {
        fetchAndSetRep(context, moradorUsuario!.repId!);
      }
      _isInit = false;
    }
  }
  
 @override
  Widget build(BuildContext context) {
    final moradorUsuario = Provider.of<MoradorProvider>(context).morador;
    final repUsuario = Provider.of<RepProvider>(context).rep;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
      body: moradorUsuario!.repId != null
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Olá, ${moradorUsuario.nome}!"),
            Text("Data de Nascimento: ${moradorUsuario.dataNascimento}"),
            Text("Curso: ${moradorUsuario.curso}"),
            Text("Rep: ${repUsuario!.nome}"),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'PERFIL DA REP',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'MEU SALDO',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'devendo',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'A receber / crédito',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Dívida'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Fluxo de Caixa'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Avaliar Rep/Membro'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ) 
      : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Opa, ${moradorUsuario?.nome}, parece que você não está cadastrado numa rep."),
            SizedBox(height: 10),
            ElevatedButton(
                    onPressed: () => _registerRep(context),
                    child: Text('Registrar uma República'),
            ),
          ],
        ),
      ),
    );
  }
}
