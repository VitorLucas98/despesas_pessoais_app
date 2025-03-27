import 'package:despesas_pessoais_app/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF6A1B9A), // Cor hexadecimal
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ), // Espaço para cima e para baixo
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Fundo diferente
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.purple), // Cor do ícone
                onPressed: () {
                  // Add action here
                },
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(color: Colors.blue, elevation: 5, child: const Text('Gráfico')),
          Column(
            children:
                _transactions.map((tr) {
                  return Card(child: Text(tr.title));
                }).toList(),
          ),
        ],
      ),
    );
  }
}
