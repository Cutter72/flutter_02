import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_02/models/transaction.dart';
import 'package:flutter_02/widgets/chart.dart';
import 'package:flutter_02/widgets/new_transaction.dart';
import 'package:flutter_02/widgets/transaction_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // needed for below settings
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]); // WidgetsFlutterBinding.ensureInitialized() must be run before these settings
  runApp(MyApp());
}

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class MyApp extends StatelessWidget {
  MyApp() {
    initLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_02',
      theme: ThemeData(
        fontFamily: "QuickSand",
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                titleLarge: TextStyle(fontFamily: "OpenSans", fontSize: 20, fontWeight: FontWeight.bold),
              )
              .headline6,
        ),
      ),
      home: MyHomePage(),
    );
  }

  void initLocale() {
    Future.wait([findSystemLocale()]);
    initializeDateFormatting(Intl.systemLocale);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      final borderDateTime = DateTime.now().subtract(Duration(days: 7));
      if (transaction.date.day >= borderDateTime.day &&
          transaction.date.month >= borderDateTime.month &&
          transaction.date.year >= borderDateTime.year) {
        return true;
      }
      return false;
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (cCtx) {
          return GestureDetector(
              onTap: () {}, behavior: HitTestBehavior.opaque, child: NewTransaction(_addTransaction));
        });
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      _transactions.add(transaction);
    });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("flutter_02"),
      actions: [IconButton(onPressed: () => _startAddNewTransaction(context), icon: Icon(Icons.add))],
    );
    return Scaffold(
      appBar: appBar,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: calculateHeight(context, appBar, 0.3),
            child: Chart(_recentTransactions),
          ),
          Container(
            height: calculateHeight(context, appBar, 0.70),
            child: TransactionList(_transactions, _deleteTransaction),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: Icon(Icons.add)),
    );
  }

  double calculateHeight(BuildContext context, AppBar appBar, double percent) {
    return (MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom -
            appBar.preferredSize.height) *
        percent;
  }
}
