import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key? key,
    required Transaction transaction,
    required Function(int transactionId) deleteTransaction,
  })  : _transaction = transaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _transaction;
  final Function(int transactionId) _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 5,
      child: Row(
        children: <Widget>[
          _Amount(colorScheme: colorScheme, mediaQuery: mediaQuery, transaction: _transaction),
          _ExpandedTitleDateColumn(colorScheme: colorScheme, transaction: _transaction, mediaQuery: mediaQuery),
          _DeleteIcon(deleteTransaction: _deleteTransaction, transaction: _transaction),
        ],
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({
    Key? key,
    required this.colorScheme,
    required this.mediaQuery,
    required Transaction transaction,
  })  : _transaction = transaction,
        super(key: key);

  final ColorScheme colorScheme;
  final MediaQueryData mediaQuery;
  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: colorScheme.primary, width: 2)),
      child: SizedBox(
        height: 20,
        child: FittedBox(
          child: Text(
            maxLines: 1,
            style: TextStyle(
                color: colorScheme.primary, fontSize: 18 * mediaQuery.textScaleFactor, fontWeight: FontWeight.bold),
            "\$${_transaction.amount.toStringAsFixed(2)}",
          ),
        ),
      ),
    );
  }
}

class _ExpandedTitleDateColumn extends StatelessWidget {
  const _ExpandedTitleDateColumn({
    Key? key,
    required this.colorScheme,
    required Transaction transaction,
    required this.mediaQuery,
  })  : _transaction = transaction,
        super(key: key);

  final ColorScheme colorScheme;
  final Transaction _transaction;
  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(colorScheme: colorScheme, transaction: _transaction),
          _Date(mediaQuery: mediaQuery, transaction: _transaction),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
    required this.colorScheme,
    required Transaction transaction,
  })  : _transaction = transaction,
        super(key: key);

  final ColorScheme colorScheme;
  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Text(
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: colorScheme.primary),
        _transaction.title.toUpperCase(),
      ),
    );
  }
}

class _Date extends StatelessWidget {
  const _Date({
    Key? key,
    required this.mediaQuery,
    required Transaction transaction,
  })  : _transaction = transaction,
        super(key: key);

  final MediaQueryData mediaQuery;
  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 14 * mediaQuery.textScaleFactor, color: Colors.grey),
            DateFormat.Hms(Intl.systemLocale).format(_transaction.date),
          ),
          Text(
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 14 * mediaQuery.textScaleFactor, color: Colors.grey),
            DateFormat.yMMMd(Intl.systemLocale).format(_transaction.date),
          ),
        ],
      ),
    );
  }
}

class _DeleteIcon extends StatelessWidget {
  const _DeleteIcon({
    Key? key,
    required Function(int transactionId) deleteTransaction,
    required Transaction transaction,
  })  : _deleteTransaction = deleteTransaction,
        _transaction = transaction,
        super(key: key);

  final Function(int transactionId) _deleteTransaction;
  final Transaction _transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
      child: IconButton(
        icon: Icon(
          Icons.delete,
          color: Theme.of(context).errorColor,
        ),
        onPressed: () => _deleteTransaction(_transaction.id),
      ),
    );
  }
}
