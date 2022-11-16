import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transaction_list_item.dart';

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
              const SizedBox(height: 5),
              const Text("Not transactions added."),
              const SizedBox(height: 5),
              SizedBox(
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
            itemBuilder: (context, index) {
              return TransactionListItem(transaction: _transactions[index], deleteTransaction: _deleteTransaction);
            },
          );
  }
}
