import 'package:flutter/material.dart';

import './transaction.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  final List<Transaction> transactions = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expense App"),
        ),
        body: Column(
          children: transactions.map((tx) {
            return Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.purple,
                        width: 2,
                      )),
                      child: Text(
                        "\$${tx.amount}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Column(
                      children: [
                        Text(
                          tx.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          tx.date.toLocal().toString(),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )
                  ],
                ),
                elevation: 5,
              ),
            );
          }).toList(),
        ),
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
