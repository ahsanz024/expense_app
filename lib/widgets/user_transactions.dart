import 'package:expense_app/widgets/new_transaction.dart';
import 'package:expense_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 'TU-1',
        amount: 33.3,
        date: DateTime.now(),
        title: "First Transaction"),
    Transaction(
        id: 'TU-2',
        amount: 234,
        date: DateTime.now(),
        title: "2nd Transaction"),
    Transaction(
        id: 'TU-2',
        amount: 234,
        date: DateTime.now(),
        title: "2nd Transaction"),
    Transaction(
        id: 'TU-2',
        amount: 234,
        date: DateTime.now(),
        title: "2nd Transaction"),
    Transaction(
        id: 'TU-2',
        amount: 234,
        date: DateTime.now(),
        title: "2nd Transaction"),
    Transaction(
        id: 'TU-2',
        amount: 234,
        date: DateTime.now(),
        title: "2nd Transaction"),
  ];

  void _addTransaction(String title, double amount) {
    final newTx = Transaction(
        id: "${_transactions.length}",
        title: title,
        date: DateTime.now(),
        amount: amount);
    setState(() {
      _transactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransacation(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
