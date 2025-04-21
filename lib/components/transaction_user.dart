import 'dart:math';

import 'package:despesas_pessoais_app/components/transaction_form.dart';
import 'package:despesas_pessoais_app/components/transaction_list.dart';
import 'package:despesas_pessoais_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {

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


_addTransaction(String title, double value){
  final transaction = Transaction(
    id: Random().nextDouble().toString(),
    title: title,
    value: value,
    date: DateTime.now(),
  );

  setState(() {
    _transactions.add(transaction);
  });
  
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}