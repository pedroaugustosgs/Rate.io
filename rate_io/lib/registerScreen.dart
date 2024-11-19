import 'package:flutter/material.dart';
import 'package:rate_io/classes/sexo.dart';
import 'routes.dart'; // Importa o arquivo de rotas
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'classes/morador.dart';
import 'package:intl/intl.dart'; // Certifique-se de importar esta biblioteca
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> navigateToRegisterScreen(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/registerScream');
}

void _login(BuildContext context) async {
  await Navigator.of(context).pushNamed(Routes.login);
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _faculdadeController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();
  final MaskedTextController _idadeController =
      MaskedTextController(mask: '00/00/0000');
  String _selectedOption =
      'Indefinido'; // COISA DE TCHOLA SÓ COLOQUEI POR QUE PRECISAVA DE UM VALOR INCIAL
  Sexo opcaoDeMacho = Sexo.naoInformado;
  // E EU IA PARECER MACHISTA SE COLOCAR HOMEM PRIMEIRO , SE COLOCAR
  // FEMININO VAI TER IDIOTA ERRANDO INFERNO
  // A GAYLANDIA ME VENCEU DESSA VEZ
  String errorMessage = '';
  String newValue = '';

  // Função para converter a opção selecionada para o enum Sexo
  Sexo getSelectedSexo() {
    switch (_selectedOption) {
      case "Masculino":
        return Sexo.masculino;
      case "Feminino":
        return Sexo.feminino;
      default:
        return Sexo.naoInformado;
    }
  }

  void _registerNewUser() async {
    DateTime dataNascimento;
    setState(() {
      errorMessage = ''; // Limpar a mensagem de erro anterior
    });

    // Validações
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _telefoneController.text.isEmpty ||
        _faculdadeController.text.isEmpty ||
        _cursoController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _idadeController.text.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    // Validação do formato do e-mail
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);
    if (!emailValid) {
      setState(() {
        errorMessage = 'Por favor, insira um e-mail válido.';
      });
      return;
    }

    try {
      dataNascimento = DateFormat('dd/MM/yyyy').parse(_idadeController.text);
    } catch (e) {
      setState(() {
        errorMessage = 'Formato de data de nascimento inválido.';
      });
      return;
    }
    try {
      dataNascimento = DateFormat('dd/MM/yyyy').parse(_idadeController.text);
    } catch (e) {
      print("Erro ao converter data: $e");
      // Você pode querer mostrar um erro ao usuário aqui
      return;
    }
      
if (_passwordController.text.length < 6) {
  setState(() {
    errorMessage = 'A senha deve ter pelo menos 6 caracteres.';
  });
  print("Error: Senha curta - ${_passwordController.text.length} caracteres");
  return;
}
    // Colete os dados do formulário
    String nome = _nameController.text;
    String email = _emailController.text;
    String telefone = _telefoneController.text;
    String faculdade = _faculdadeController.text;
    String curso = _cursoController.text;
    Sexo sexo = opcaoDeMacho;

    // Crie um novo usuário
    Morador newUser = Morador(
        nome: nome,
        email: email,
        telefone: telefone,
        dataNascimento: dataNascimento,
        faculdade: faculdade,
        curso: curso,
        sexo: sexo);

    FirebaseFirestore.instance.collection('moradores');
    try {
      // Crie o usuário no Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password:
            _passwordController.text, // Use a senha do controlador de senha
      );
      // Obtenha o ID do usuário
      String userId = userCredential.user!.uid;
      newUser.id = userId;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('moradores');

      // Adicione o usuário na coleção do Firestore
      await usersCollection
          .doc(userId)
          .set(newUser.toMap()); // Salve os dados do usuário
      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      print("Erro ao salvar usuário: $e");
      // Você pode querer lidar com erros aqui
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50),
                  SelectionContainer.disabled(
                    child: Transform.translate(
                      offset: Offset(0, -100),
                      child: Text(
                        'rate.io',
                        style: TextStyle(
                          fontSize: 98,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontFamily: 'K2D',
                          letterSpacing: 2.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _telefoneController,
                      decoration: InputDecoration(labelText: 'Telefone'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _idadeController,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'Data de Nascimento',
                        hintText: 'dd/MM/yyyy',
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _faculdadeController,
                      decoration: InputDecoration(labelText: 'Faculdade'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _cursoController,
                      decoration: InputDecoration(labelText: 'Curso'),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Senha'),
                      obscureText: false,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 16, left: 16, bottom: 30),
                    child: DropdownButtonFormField<String>(
                      value: _selectedOption, // Valor inicial
                      items: [
                        DropdownMenuItem(
                          child: Text("Masculino"),
                          value: "Masculino",
                        ),
                        DropdownMenuItem(
                          child: Text("Feminino"),
                          value: "Feminino",
                        ),
                        DropdownMenuItem(
                          child: Text("Indefinido"),
                          value: "Indefinido",
                        ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          _selectedOption = newValue!; // Atualiza a seleção
                          opcaoDeMacho = getSelectedSexo();
                        });
                      },
                      decoration:
                          InputDecoration(labelText: 'Escolha uma opção'),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _registerNewUser(),
                    child: Text('Registrar-se'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Voltar'),
                  ),
                  SizedBox(height: 20),
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
