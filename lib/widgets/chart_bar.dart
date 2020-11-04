import 'dart:ffi';

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double amountPercentage;

  ChartBar(
    this.label,
    this.amountSpent,
    this.amountPercentage,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Column(
          children: [
            FittedBox(
              child: Text("\$${amountSpent.toStringAsFixed(0)}"),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: constraints.heightConstraints().biggest.height * 0.5,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: double.infinity,
                  ),
                  FractionallySizedBox(
                    heightFactor: this.amountPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: this.amountPercentage,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(label)
          ],
        ),
      );
    },);
  }
}
