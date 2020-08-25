import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewTransacation extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  final Function addTx;

  NewTransacation(this.addTx);

  @override
  Widget build(BuildContext context) {
    void submit() {
      double amount = double.parse(amountController.text);
      addTx(titleController.text, amount);
    }

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => submit(),
            ),
            FlatButton(
              onPressed: submit,
              child: Text("Add Transaction"),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
