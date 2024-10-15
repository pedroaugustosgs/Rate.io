import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'classes/rep.dart';
import 'package:intl/intl.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_auth/firebase_auth.dart';

Future<void> navigateToRepRegisterScreen(BuildContext context) async {
  Navigator.of(context).pushReplacementNamed('/repRegisterScream');
}

void _login(BuildContext context) async {
    await Navigator.of(context).pushNamed(Routes.login);
}

class RepRegisterPage extends StatefulWidget {
  const RepRegisterPage({super.key});

  @override
  _RepRegisterPage createState() => _RepRegisterPage();
}

class _RepRegisterPage extends State<RepRegisterPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  //final TextEditingController _foundationYearController = TextEditingController();
  final MaskedTextController _foundationYearController = MaskedTextController(mask: '0000');
  double _sliderValue = 0.0;
  String _selectedOption = 'Mista';
  String errorMessage = '';

  void _registerNewRep() async {
    DateTime foundationYear;
    setState(() {
      errorMessage = '';
    });
    if (_nameController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _foundationYearController.text.isEmpty ||
        _selectedOption.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, preencha todos os campos.';
      });
      return;
    }

    try {
      foundationYear = DateFormat('yyyy').parse(_foundationYearController.text);
    } catch (e) {
      setState(() {
        errorMessage = 'Formato de ano de fundação inválido.';
      });
      return;
    }

    try {
      foundationYear = DateFormat('yyyy').parse(_foundationYearController.text);
    } catch (e) {
      print("Erro ao converter data: $e");
      return;
    }

    RepModel newRep = RepModel(
        nome: _nameController.text,
        anoFundacao: foundationYear,
        endereco: _addressController.text,
        lotacao: _sliderValue.round(),
        tipoSexo: _selectedOption);

    FirebaseFirestore.instance.collection('republicas');
    try {
      CollectionReference repCollection =
        FirebaseFirestore.instance.collection('republicas');
      
      String generatedRepId = repCollection.doc().id;
      newRep.id = generatedRepId;

      await repCollection
          .doc(generatedRepId)
          .set(newRep.toMap());

      Navigator.of(context).pushReplacementNamed('/');
    } catch (e) {
      print("Erro ao salvar república: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectionContainer.disabled(
              child: Transform.translate(
                offset: const Offset(0, -150), // Mover 400px para cima (y negativo)
                child: const Text(
                  'rate.io',
                  style: TextStyle(
                    fontSize: 98,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontFamily: 'K2D',
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome da República'),
            ),
            TextField(
              controller: _foundationYearController,
              decoration: const InputDecoration(labelText: 'Ano de Fundação'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            Text('Lotação: ${_sliderValue.round()}'),
            Slider(
              value: _sliderValue,
              min: 0.0,
              max: 30.0,
              divisions: 30,
              label: _sliderValue.round().toString(), 
              onChanged: (double newValue) {
                setState(() {
                  _sliderValue = newValue;
                });
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedOption,
              items: [
                DropdownMenuItem(
                  value: "Masculina",
                  child: Text("Masculina"),
                ),
                DropdownMenuItem(
                  value: "Feminina",
                  child: Text("Feminina"),
                ),
                DropdownMenuItem(
                  value: "Mista",
                  child: Text("Mista"),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedOption = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Escolha uma opção'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
               onPressed: () => _registerNewRep(),
              child: const Text('Registrar rep'),
            ),
            const SizedBox(height: 20),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}