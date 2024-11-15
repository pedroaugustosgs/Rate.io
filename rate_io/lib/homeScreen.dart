import 'package:flutter/material.dart';
import 'package:rate_io/classes/morador.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:provider/provider.dart';
import 'routes.dart';

Future<void> navigateToHomeScream(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/homeScream');
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  void _registerRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.repRegisterScream);
  }

 @override
  Widget build(BuildContext context) {
    Morador? moradorUsuario = Provider.of<MoradorProvider>(context).morador;

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
      body: moradorUsuario != null && moradorUsuario.rep != null
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Olá, ${moradorUsuario.nome}!"),
            Text("Data de Nascimento: ${moradorUsuario.dataNascimento}"),
            Text("Curso: ${moradorUsuario.curso}"),
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
