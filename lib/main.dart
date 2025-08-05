import 'dart:math';

import 'package:despesas_pessoais_app/components/chart/chart.dart';
import 'package:despesas_pessoais_app/components/transaction/transaction_form.dart';
import 'package:despesas_pessoais_app/components/transaction/transaction_list.dart';
import 'package:despesas_pessoais_app/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.purple,
        useMaterial3: false,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final tituloController = TextEditingController();

  final valorController = TextEditingController();
  final List<Transaction>_transactions = [
    Transaction(
      id: 't0',
      title: 'Conta Antiga',
      value: 400.00,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),    Transaction(
      id: 't3',
      title: 'Conta de Agua',
      value: 93.60,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't4',
      title: 'Novo Celular',
      value: 2000.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't5',
      title: 'Cinema',
      value: 150.00,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),  
  ];

  List<Transaction> get _recentTransactions {
    // Filtra as transações para incluir apenas aquelas dos últimos 7 dias
    return _transactions.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  _addTransaction(String title, double value) {
    final transaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop(); // Fecha o modal após adicionar a transação
  }

  _openTransactionForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Despesas Pessoais',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                icon: Icon(Icons.add, color:Theme.of(context).primaryColor), // Cor do ícone
                onPressed: () => _openTransactionForm(context),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white), // Cor do ícone
        backgroundColor: Color(0xFF6A1B9A), // Cor hexadecimal
        onPressed: () => _openTransactionForm(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
