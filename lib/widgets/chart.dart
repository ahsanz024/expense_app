import 'dart:math';

import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  double get maxSpending {
    return this.getGroupedTransactionValues.fold(
      0,
      (previousValue, element) {
        return previousValue += element['amount'];
      },
    );
  }

  List<Map<String, Object>> get getGroupedTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );
        double amount = 0;
        for (var i = 0; i < recentTransactions.length; i++) {
          final tx = recentTransactions[i];
          if (weekDay.day == tx.date.day &&
              weekDay.month == tx.date.month &&
              weekDay.year == tx.date.year) {
            amount += tx.amount;
          }
        }
        print(
            "Amount $amount  Weekday ${DateFormat.E().format(weekDay).substring(0, 1)}");

        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': amount,
        };
      },
    ).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    // getGroupedTransactionValues;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            ...getGroupedTransactionValues.map((dailyTx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  dailyTx['day'],
                  dailyTx['amount'],
                  maxSpending == 0.0
                      ? 0.0
                      : (dailyTx['amount'] as double) / maxSpending,
                ),
              );
            }).toList(),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}
