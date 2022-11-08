import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  late final Function(Transaction) _addTransaction;

  NewTransaction(Function(Transaction) addTransaction) {
    _addTransaction = addTransaction;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Amount \$.\$\$"),
              controller: amountController,
              onChanged: (input) => {print("onChanged: input=${amountController.text}")},
              onEditingComplete: () => {print("onEditingComplete")},
              onSubmitted: (input) => {print("onSubmitted: input=$input")},
            ),
            ElevatedButton(
              child: Text("Add transaction"),
              onPressed: () => _addTransaction(
                  Transaction(title: titleController.text, amount: double.tryParse(amountController.text))),
            ),
          ],
        ),
      ),
    );
  }
}
