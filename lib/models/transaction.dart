///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class Transaction {
  static int nextId = 0;
  late final int _id;
  late final String _title;
  late final double _amount;
  late final DateTime _date;

  Transaction({required String? title, required double? amount, DateTime? date}) {
    _id = nextId;
    _title = title == null || title.isEmpty ? "No title" : title;
    _amount = amount ?? -0;
    _date = date ?? DateTime.now();
    nextId++;
  }

  int get id => _id;

  String get title => _title;

  double get amount => _amount;

  DateTime get date => _date;
}
