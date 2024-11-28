import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'routes.dart';

Future<void> navigateToHomeScreen(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/homeScreen');
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int _currentIndex = 1;
  void _registerRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.repRegisterScreen);
  }

  void _avaliaRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.avaliaRepScreen);
  }

  void _cadastraEvento(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.cadastrarEventoScreen);
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
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex == index) {
            return; // Se o botão clicado for igual ao referente à tela atual, nada acontece
          }
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(
              context,
              Routes.editarPerfilMoradorScreen,
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
      body: moradorUsuario!.repId != null
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Olá, ${moradorUsuario.nome}!"),
            Text("Data de Nascimento: ${DateFormat('dd/MM/yyyy').format(moradorUsuario.dataNascimento)}"),
            Text("Curso: ${moradorUsuario.curso}"),
            Text("Rep: ${repUsuario?.nome}"),
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
                    onPressed: () => _avaliaRep(context),
                    child: Text('Avaliar Rep'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _cadastraEvento(context),
                    child: Text('Cadastrar Evento (teste)'),
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
            Text("Opa, ${moradorUsuario.nome}, parece que você não está cadastrado numa rep."),
            SizedBox(height: 10),
            ElevatedButton(
                    onPressed: () => _registerRep(context),
                    child: Text('Criar uma República'),
            ),
          ],
        ),
      ),
    );
  }
}
