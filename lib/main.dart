import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    return Platform.isIOS ? CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: Colors.purple,
      ),
      title: 'Expense App',
      home: HomePage(),
    ) : MaterialApp(
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
  var _showChart = true;
  final List<Transaction> _transactions = [
    Transaction(
      id: "1",
      title: "test",
      date: DateTime.now().subtract(Duration(days: 3)),
      amount: 3,
    ),
    Transaction(
      id: "2",
      title: "test",
      date: DateTime.now().subtract(Duration(days: 2)),
      amount: 4,
    ),
    Transaction(
      id: "2",
      title: "test",
      date: DateTime.now().subtract(Duration(days: 2)),
      amount: 4,
    ),
    Transaction(
      id: "2",
      title: "test",
      date: DateTime.now().subtract(Duration(days: 2)),
      amount: 4,
    ),
    Transaction(
      id: "2",
      title: "test",
      date: DateTime.now().subtract(Duration(days: 2)),
      amount: 4,
    ),
    Transaction(
      id: "2",
      title: "test",
      date: DateTime.now().subtract(Duration(days: 6)),
      amount: 6,
    ),
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
    final isIOS = Platform.isIOS;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = isIOS ? CupertinoNavigationBar(
      middle: Text("Expense App"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ]
      ),
    ) : AppBar(
      title: Text("Expense App"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );

    print("appbar ${appBar.preferredSize.height}");
    final txList = Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: TransactionList(_transactions, _deleteTransaction),
    );

    final body = SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch.adaptive(
                  value: _showChart, 
                  onChanged: (val) {
                    setState(() {
                      this._showChart = val;
                    });
                  },
                ),
                Text("Show Chart")
              ],
            ),
            if (!isLandscape) 
              Container(
                // height: MediaQuery.of(context).size.height * 0.5,
                height: (
                  MediaQuery.of(context).size.height - 
                  appBar.preferredSize.height - 
                  MediaQuery.of(context).padding.top
                  ) * 0.2,
                width: double.infinity,
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: Chart(_recentTransactions),
                  elevation: 5,
                ),
              ),
            if (!isLandscape)
              txList,
            if (isLandscape) 
              _showChart ? Container(
                  // height: MediaQuery.of(context).size.height * 0.5,
                  height: (
                    MediaQuery.of(context).size.height - 
                    appBar.preferredSize.height - 
                    MediaQuery.of(context).padding.top
                    ) * 0.7,
                  width: double.infinity,
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: Chart(_recentTransactions),
                    elevation: 5,
                  ),
                ) : txList
          ],
        ),
      )
    );

    return isIOS ? 
      CupertinoPageScaffold(
        child: body,
        navigationBar: appBar,
      ) : Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}
