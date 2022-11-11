import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:intl/intl.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class NewTransaction extends StatefulWidget {
  late final Function(Transaction) _addTransaction;

  NewTransaction(Function(Transaction) addTransaction) {
    _addTransaction = addTransaction;
  }

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Amount \$.\$\$", border: OutlineInputBorder()),
              controller: amountController,
              onChanged: (input) => {print("onChanged: input=${amountController.text}")},
              onEditingComplete: () => {print("onEditingComplete")},
              onSubmitted: (input) => {submitTransaction()},
            ),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    border: Border.all(color: Theme.of(context).disabledColor)),
                child: TextButton(
                  child: Text("Date: ${DateFormat.yMd(Intl.systemLocale).format(DateTime.now())}",
                      textAlign: TextAlign.justify),
                  onPressed: () {
                    final today = DateTime.now();
                    showDatePicker(
                            context: context, initialDate: today, firstDate: DateTime(today.year - 1), lastDate: today)
                        .then((pickedDate) {
                      if (pickedDate != null) {}
                    });
                  },
                ),
              ),
            ),
            ElevatedButton(
              child: Text("Add transaction"),
              onPressed: submitTransaction,
            ),
          ],
        ),
      ),
    );
  }

  submitTransaction() {
    // if (titleController.text.isEmpty || amountController.text.isEmpty) {
    //   return;
    // } else {
    widget._addTransaction(Transaction(title: titleController.text, amount: double.tryParse(amountController.text)));
    // }
    Navigator.of(context).pop();
  }
}
