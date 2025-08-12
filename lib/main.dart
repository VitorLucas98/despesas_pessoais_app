import 'dart:io';
import 'dart:math';

import 'package:despesas_pessoais_app/components/chart/chart.dart';
import 'package:despesas_pessoais_app/components/transaction/transaction_form.dart';
import 'package:despesas_pessoais_app/components/transaction/transaction_list.dart';
import 'package:despesas_pessoais_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
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

  bool _showChart = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    // Filtra as transações para incluir apenas aquelas dos últimos 7 dias
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
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
    final mediaQuery = MediaQuery.of(context);

    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    Widget _getIconButton(IconData icon, Function() fn) {
      return Platform.isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(onPressed: fn, icon: Icon(icon));
    }

    final actions = [
      if (isLandscape)
      _getIconButton(_showChart ? Icons.list : Icons.bar_chart, () {
        setState(() {
          _showChart = !_showChart;
        });
      }),
      _getIconButton(Icons.add, () => _openTransactionForm(context)),
    ];

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
      actions: actions,
    );

    final availableHeight =
        mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 0.7 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _removeTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min, 
              children: actions),
          ),
          child: bodyPage,
        )
        : Scaffold(
          appBar: appBar,
          body: bodyPage,
          floatingActionButton: Platform.isIOS
                  ? Container()
                  : FloatingActionButton(
                    child: Icon(Icons.add, color: Colors.white), // Cor do ícone
                    backgroundColor: Color(0xFF6A1B9A), // Cor hexadecimal
                    onPressed: () => _openTransactionForm(context),
                  ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        );
  }
}
