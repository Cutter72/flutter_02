import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:flutter_02/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get summaryTransactionsPerDay {
    var weekAmountSum = 0.0;
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
      weekAmountSum += dayAmountSum;
      return {'day': DateFormat.E(Intl.systemLocale).format(weekDay), 'amount': dayAmountSum};
    }).map((dayData) {
      dayData['percent'] = weekAmountSum == 0.0 ? 0.0 : (dayData['amount'] as double) / weekAmountSum;
      return dayData;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(12),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...summaryTransactionsPerDay
                .map((dayData) {
                  return Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          child: FittedBox(child: Text("\$${(dayData['amount'] as double).toStringAsFixed(0)}")),
                        ),
                        ChartBar(dayData['percent'] as double),
                        Text("${dayData['day']}"),
                      ],
                    ),
                  );
                })
                .toList()
                .reversed
          ],
        ),
      ),
    );
  }
}
