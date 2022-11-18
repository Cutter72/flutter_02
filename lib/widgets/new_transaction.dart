import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

/// Extension functions for dimension operations.
extension Dimens on num {
  /// 1cm = 64 lp/fp (logical pixels/flutter pixels).
  /// Calculated from 960px = 640lp/fp = 10cm also 540px = 360lp/fp = 5,6cm
  static const _cm = 64.0;

  double asCentimeters() {
    return this * _cm;
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var today = DateTime.now();
  var pickedDate = DateTime.now();

  getDisplayMetrics() async {
    if (Platform.isAndroid) {
      const platform = MethodChannel("myChannel");
      try {
        final String dpi = await platform.invokeMethod("getDisplayMetrics");
        print("getDisplayMetrics=$dpi");
      } on PlatformException catch (err) {
        print("getDisplayMetrics_err=$err");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDisplayMetrics();
    final mqd = MediaQuery.of(context);
    print("size=${mqd.size}");
    print("devicePixelRatio=${mqd.devicePixelRatio}");
    print("textScaleFactor=${mqd.textScaleFactor}");
    print("displayFeatures=${mqd.displayFeatures}");

    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InputTitle(titleController: titleController),
          SizedBox(
            height: 72,
            child: TextField(
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Amount \$.\$\$", border: OutlineInputBorder()),
              controller: amountController,
              onSubmitted: (input) => submitTransaction(),
            ),
          ),
          SizedBox(
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  border: Border.all(color: Theme.of(context).disabledColor)),
              child: TextButton(
                onPressed: showDatePickerToUser,
                child:
                    Text("Date: ${DateFormat.yMd(Intl.systemLocale).format(pickedDate)}", textAlign: TextAlign.justify),
              ),
            ),
          ),
          Container(
            height: 1.asCentimeters(),
            margin: const EdgeInsets.only(top: 12),
            child: ElevatedButton(
              onPressed: submitTransaction,
              child: const Text("Add transaction"),
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

class _InputTitle extends StatelessWidget {
  const _InputTitle({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: TextField(
        decoration: const InputDecoration(labelText: "Title", border: OutlineInputBorder()),
        controller: titleController,
      ),
    );
  }
}
