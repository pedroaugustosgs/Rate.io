import 'package:flutter/material.dart';

class FluxoDeCaixaScreen extends StatefulWidget {
  @override
  _FluxoDeCaixaScreenState createState() => _FluxoDeCaixaScreenState();
}

class _FluxoDeCaixaScreenState extends State<FluxoDeCaixaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluxo de Caixa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastrarContaScreen');
              },
              child: const Text('Cadastrar Conta'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cadastrarPagamentoScreen');
              },
              child: const Text('Cadastrar Pagamento'),
            ),
          ],
        ),
      ),
    );
  }
}
