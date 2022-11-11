import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:intl/intl.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get summaryTransactionsPerDay {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var dayAmountSum = 0.0;
      for (var transaction in recentTransactions) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          dayAmountSum += transaction.amount;
        }
      }
      return {'day': DateFormat.E(Intl.systemLocale).format(weekDay), 'amount': dayAmountSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...summaryTransactionsPerDay.map((e) => Column(
            children: [
              Text("\$${(e['amount'] as double).toStringAsFixed(0)}"),
              Text("\$"),
              Text("${e['day']}"),
            ],
          )).toList().reversed
        ],
      ),
    );
  }
}
