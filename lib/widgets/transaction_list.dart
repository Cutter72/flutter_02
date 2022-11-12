import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:intl/intl.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class TransactionList extends StatelessWidget {
  late final List<Transaction> _transactions;
  late final Function(int) _deleteTransaction;

  TransactionList(List<Transaction> transactions, Function(int) deleteTransaction) {
    _transactions = transactions;
    _deleteTransaction = deleteTransaction;
  }

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
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
                      constraints: BoxConstraints(maxWidth: 100),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2)),
                      child: SizedBox(
                        height: 20,
                        child: FittedBox(
                          child: Text(
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                                fontWeight: FontWeight.bold),
                            "\$${_transactions[i].amount.toStringAsFixed(2)}",
                          ),
                        ),
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
                                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                  style: TextStyle(
                                      fontSize: 14 * MediaQuery.of(context).textScaleFactor, color: Colors.grey),
                                  "${DateFormat.Hms(Intl.systemLocale).format(_transactions[i].date)}",
                                ),
                                Text(
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontSize: 14 * MediaQuery.of(context).textScaleFactor, color: Colors.grey),
                                  "${DateFormat.yMMMd(Intl.systemLocale).format(_transactions[i].date)}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        onPressed: () => _deleteTransaction(_transactions[i].id),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
