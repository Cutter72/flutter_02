import 'package:flutter/material.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:flutter_02/widgets/new_transaction.dart';
import 'package:flutter_02/widgets/transaction_list.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(title: "title1", amount: 1.99),
    Transaction(title: "title2", amount: 2.9),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }

  _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }
}
