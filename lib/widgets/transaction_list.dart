import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:intl/intl.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class TransactionList extends StatelessWidget {
  late final List<Transaction> _transactions;

  TransactionList(List<Transaction> transactions) {
    _transactions = transactions;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: [
                SizedBox(height: 5),
                Text("Not transactions added."),
                SizedBox(height: 5),
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/empty_transaction_list.png",
                      fit: BoxFit.contain,
                    )),
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 5,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
                        child: Text(
                          maxLines: 1,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold),
                          "\$${_transactions[i].amount.toStringAsFixed(2)}",
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                              child: Text(
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Theme.of(context).primaryColor),
                                _transactions[i].title.toUpperCase(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                    "${DateFormat.Hms(Intl.systemLocale).format(_transactions[i].date)}",
                                  ),
                                  Text(
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                    "${DateFormat.yMMMd(Intl.systemLocale).format(_transactions[i].date)}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
