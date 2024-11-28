import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> navigateToHomeScreen(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/homeScreen');
}

void saveIdRep(String key, String? value) async {
  if (value == null) {
    print('repId é nulo, nada foi salvo.');
    return;
  }

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
  print('repId salvo: $value');
}

Future<String?> getIdRep(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  print('repId recuperado: $value');
  return value;
}

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  void _registerRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.repRegisterScreen);
  }

  void _avaliaRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.avaliaRepScreen);
  }

  void _listarMoradores(BuildContext context, Rep rep) async {
    print(rep.id);
    await Navigator.of(context).pushNamed(
      Routes.mostraMoradoresScreen,
      arguments: rep, // Passa o objeto Rep inteiro
    );
  }

  bool _isInit = true;

  Future<void> fetchAndSetRep(BuildContext context, String uid) async {
    try {
      String? repId = await getIdRep('repId');
      if (repId == null) {
        print('repId is null');
        return;
      } else {
        print('Rep ID retrieved: $repId');
      }

      print('Rep ID AAAAAAAAAAAAA: $repId');
      print("REP ID SALVO NA MEMÓRIA: ${repId}");

      // Verifique se o uid está correto
      print("Consultando a república com o UID: $uid");

      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('republicas')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        print('Dados da república: ${snapshot.data()}');
        var repData = snapshot.data();
        if (repData != null) {
          print('Dados para conversão: $repData');
          Rep rep = Rep.fromMap(repData);
          print('Rep ID: ${rep.id}');
          // Continue o processo
        } else {
          print('Dados da república estão vazios');
        }
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
    if (_isInit) {
      final moradorUsuario = Provider.of<MoradorProvider>(context).morador;
      if (moradorUsuario?.repId != null) {
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
                  Text(
                      "Data de Nascimento: ${DateFormat('dd/MM/yyyy').format(moradorUsuario.dataNascimento)}"),
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
                          onPressed: () {
                            if (repUsuario != null) {
                              _listarMoradores(context,
                                  repUsuario!); // `repUsuario` é passado aqui
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Nenhuma república selecionada!')),
                              );
                            }
                          },
                          child: Text('Moradores'),
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
                  Text(
                      "Opa, ${moradorUsuario.nome}, parece que você não está cadastrado numa rep."),
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
