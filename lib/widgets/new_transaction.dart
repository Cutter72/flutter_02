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
  var today = DateTime.now();
  var pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 72,
            child: TextField(
              decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
              controller: titleController,
            ),
          ),
          Container(
            height: 72,
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Amount \$.\$\$", border: OutlineInputBorder()),
              controller: amountController,
              onSubmitted: (input) => submitTransaction(),
            ),
          ),
          Container(
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Theme.of(context).disabledColor)),
              child: TextButton(
                onPressed: showDatePickerToUser,
                child:
                    Text("Date: ${DateFormat.yMd(Intl.systemLocale).format(pickedDate)}", textAlign: TextAlign.justify),
              ),
            ),
          ),
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 12),
            child: ElevatedButton(
              onPressed: submitTransaction,
              child: Text("Add transaction"),
            ),
          ),
        ],
      ),
    );
  }

  void showDatePickerToUser() {
    showDatePicker(context: context, initialDate: today, firstDate: DateTime(today.year - 1), lastDate: today)
        .then((pickedDate) {
      if (pickedDate != null) {
        savePickedDate(pickedDate);
      }
    });
  }

  void savePickedDate(DateTime pickedDate) {
    setState(() {
      this.pickedDate = pickedDate;
    });
  }

  submitTransaction() {
    // if (titleController.text.isEmpty || amountController.text.isEmpty) {
    //   return;
    // } else {
    widget._addTransaction(
        Transaction(title: titleController.text, amount: double.tryParse(amountController.text), date: pickedDate));
    // }
    Navigator.of(context).pop();
  }
}
