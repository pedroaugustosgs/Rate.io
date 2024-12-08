import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rate_io/classes/moradorProvider.dart';
import 'package:provider/provider.dart';
import 'package:rate_io/classes/rep.dart';
import 'package:rate_io/classes/repProvider.dart';
import 'package:rate_io/perfilUsuarioScreen.dart';
import 'package:rate_io/verAvaliacoesRepScreen.dart';
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
  int _anteriorIndex = 0;
  void _registerRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.repRegisterScreen);
  }

  void _avaliaRep(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.avaliaRepScreen);
  }

    void __fluxoDeCaixa(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.fluxoDeCaixaScreen);
  }

  void _cadastraEvento(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.cadastrarEventoScreen);
  }

  Widget _navigatePerfilUsuario({required Map<String, dynamic> morador}) {
  return PerfilUsuarioScreen(morador: morador);
}

  void _listarMoradores(BuildContext context, Rep rep) async {
    print(rep.id);
    await Navigator.of(context).pushNamed(
      Routes.mostraMoradoresScreen,
      arguments: rep, 
    );
  }

  bool _isInit = true;

  Future<void> fetchAndSetRep(BuildContext context, String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('republicas')
          .doc(uid)
          .get();

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
    if (_isInit) {
      final meuPerfil = Provider.of<MoradorProvider>(context).morador;
      if (meuPerfil?.repId != null) {
        fetchAndSetRep(context, meuPerfil!.repId!);
      }
      _isInit = false;
    }
  }

  int calculaIdade(DateTime dataNascimento) {
    DateTime hoje = DateTime.now();
    int age = hoje.year - dataNascimento.year;
    if (hoje.month < dataNascimento.month || 
        (hoje.month == dataNascimento.month && hoje.day < dataNascimento.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    final meuPerfil = Provider.of<MoradorProvider>(context).morador;
    final minhaRep = Provider.of<RepProvider>(context).rep;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (_currentIndex == index && _anteriorIndex == index) {
            return; // Se o botão clicado for igual ao referente à tela atual, nada acontece
          }
          setState(() {
            _anteriorIndex = _currentIndex;
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(
              context,
              Routes.buscaScreen,
              arguments: meuPerfil,
            );
          } else if (index == 1) {
            Navigator.pushNamed(
              context,
              Routes.homeScreen,
            );
          } else if (index == 2) {
            Navigator.push( 
              context,
              MaterialPageRoute(
                builder: (context) => _navigatePerfilUsuario(morador: meuPerfil!.toMap()),
              ),
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
      body: meuPerfil!.repId != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Olá, ${meuPerfil.nome}!"),
                  Text(
                      "Idade: ${calculaIdade(meuPerfil.dataNascimento)}"),
                  Text("Curso: ${meuPerfil.curso}"),
                  Text("Rep: ${minhaRep?.nome}"),
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
                          onPressed: () {
                            _anteriorIndex = -1;
                            __fluxoDeCaixa(context);
                          },
                          child: Text('Fluxo de Caixa'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _anteriorIndex = -1;
                            _avaliaRep(context);
                          },
                          child: Text('Avaliar Rep'),
                        ),
                        SizedBox(height: 10),
                        if(meuPerfil.id == minhaRep?.moradorADMId)
                          ElevatedButton(
                            onPressed: () {
                              _anteriorIndex = -1;
                              _cadastraEvento(context);
                            },
                            child: Text('Cadastrar Evento'),
                          ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (minhaRep != null) {
                              _anteriorIndex = -1;
                              _listarMoradores(context,
                                  minhaRep); 
                            } else {
                              _anteriorIndex = -1;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text('Nenhuma república selecionada!')),
                              );
                            }
                          },
                          child: Text('Moradores'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _anteriorIndex = -1;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerAvaliacoesRepScreen(rep: minhaRep!.toMap()),
                              ),
                            );
                          },
                          child: Text('Ver Avaliações'),
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
                      "Opa, ${meuPerfil.nome}, parece que você não está cadastrado numa rep."),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _anteriorIndex = -1;
                      _registerRep(context);
                    },
                    child: Text('Criar uma República'),
                  ),
                  
                ],
              ),
            ),
    );
  }
}
