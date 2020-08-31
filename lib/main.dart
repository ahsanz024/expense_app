import 'package:flutter/material.dart';

import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData themeData = ThemeData(
    primarySwatch: Colors.purple,
    buttonColor: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      title: 'Expense App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: "1",
    //   title: "test",
    //   date: DateTime.now().subtract(Duration(days: 3)),
    //   amount: 3,
    // ),
    // Transaction(
    //   id: "2",
    //   title: "test",
    //   date: DateTime.now().subtract(Duration(days: 2)),
    //   amount: 4,
    // ),
    // Transaction(
    //   id: "2",
    //   title: "test",
    //   date: DateTime.now().subtract(Duration(days: 2)),
    //   amount: 4,
    // ),
    // Transaction(
    //   id: "2",
    //   title: "test",
    //   date: DateTime.now().subtract(Duration(days: 2)),
    //   amount: 4,
    // ),
    // Transaction(
    //   id: "2",
    //   title: "test",
    //   date: DateTime.now().subtract(Duration(days: 2)),
    //   amount: 4,
    // ),
    // Transaction(
    //   id: "2",
    //   title: "test",
    //   date: DateTime.now().subtract(Duration(days: 6)),
    //   amount: 6,
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    print(title);
    final newTx = Transaction(
      id: "${DateTime.now()}",
      title: title,
      date: date,
      amount: amount,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      this._transactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransacation(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense App"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: Theme.of(context).primaryColor,
                child: Chart(_recentTransactions),
                elevation: 5,
              ),
            ),
            TransactionList(_transactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
