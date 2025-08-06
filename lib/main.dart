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
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.59,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't3',
      title: 'Conta de Água',
      value: 150.00,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 't4',
      title: 'Novo Celular',
      value: 1200.00,
      date: DateTime.now().subtract(const Duration(days: 10)),
    ),
    Transaction(
      id: 't5',
      title: 'Curso de Flutter',
      value: 299.99,
      date: DateTime.now().subtract(const Duration(days: 12)),
    ),
    Transaction(
      id: 't6',
      title: 'Assinatura Netflix',
      value: 39.90,
      date: DateTime.now().subtract(const Duration(days: 15)),
    ),
    Transaction(
      id: 't7',
      title: 'Jantar no Restaurante',
      value: 89.90,
      date: DateTime.now().subtract(const Duration(days: 2)),
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

  _addTransaction(String title, double value, DateTime date) {
    final transaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(transaction);
    });

    Navigator.of(context).pop(); // Fecha o modal após adicionar a transação
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
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

    final appBar = AppBar(
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
      );

      final availableHeight = MediaQuery.of(context).size.height - 
      appBar.preferredSize.height -
      MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: availableHeight * 0.3,
              child: Chart(_recentTransactions)),
            SizedBox(
              height: availableHeight * 0.7,
              child: TransactionList(_transactions, _removeTransaction)),
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
