import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  String amountText;
  String titleText;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(
      primaryColor: Colors.purple,
    );

    return MaterialApp(
      theme: themeData,
      themeMode: ThemeMode.dark,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Expense App"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Text("Charts"),
                ),
                UserTransactions(),
              ],
            ),
          )
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () => print("FAB Pressed"),
          //   child: Text(
          //     "+",
          //     style: TextStyle(fontSize: 32),
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          ),
    );
  }
}
