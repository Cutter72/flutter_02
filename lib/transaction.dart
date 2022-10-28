///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Transaction {
  late final String _id;
  late final String _title;
  late final double _amount;
  late final DateTime _date;

  Transaction({required id, required title, required amount, required date}) {
    _id = id;
    _title = title;
    _amount = amount;
    _date = date;
  }

  String get id => _id;

  String get title => _title;

  double get amount => _amount;

  DateTime get date => _date;
}
