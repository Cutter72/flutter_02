import 'dart:math';
import 'dart:ui';

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
  // lockOrientation();
  runApp(MyApp());
}

void lockOrientation() {
  WidgetsFlutterBinding.ensureInitialized(); // needed for below settings
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]); // WidgetsFlutterBinding.ensureInitialized() must be run before these settings
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple).copyWith(
          secondary: Colors.amber,
          // primary: Colors.green,
          // onSurface: Colors.green,
          // onPrimary: Colors.green,
          // onBackground: Colors.green,
          // onError: Colors.green,
          // onErrorContainer: Colors.green,
          // onInverseSurface: Colors.green,
          // onPrimaryContainer: Colors.green,
          // onSecondaryContainer: Colors.green,
          // onSecondary: Colors.green,
          // onSurfaceVariant: Colors.green,
          // onTertiary: Colors.green,
          // onTertiaryContainer: Colors.green,
          // background: Colors.green,
          // errorContainer: Colors.green,
          // inversePrimary: Colors.green,
          // secondaryVariant: Colors.green,
          // error: Colors.green,
          // inverseSurface: Colors.green,
          // outline: Colors.green,
          // primaryContainer: Colors.green,
          // primaryVariant: Colors.green,
          // secondaryContainer: Colors.green,
          // shadow: Colors.green,
          // surface: Colors.green,
          // surfaceTint: Colors.green,
          // surfaceVariant: Colors.green,
          // tertiary: Colors.green,
          // tertiaryContainer: Colors.green,
        ),
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
                titleLarge: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
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
  var isChartEnabled = true;

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
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(cCtx).viewInsets.bottom),
                    child: NewTransaction(_addTransaction)),
              ));
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
    final mediaQuery = MediaQuery.of(context);
    final isInLandscape = mediaQuery.orientation == Orientation.landscape;
    final theme = Theme.of(context);
    final appBar = AppBar(
      title: Text("flutter_02"),
      // actions: [IconButton(onPressed: () => _startAddNewTransaction(context), icon: Icon(Icons.add))],
      actions: [
        if (isInLandscape)
          Row(children: [
            Text("Chart"),
            Switch.adaptive(
              activeColor: theme.colorScheme.secondary,
              value: isChartEnabled,
              onChanged: (enabled) {
                setState(() => isChartEnabled = enabled);
              },
            ),
          ])
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        // SafeArea widget fixes iOS wrong placement
        child: ListView(
          children: <Widget>[
            if ((isInLandscape && isChartEnabled) || !isInLandscape)
              Container(
                height: calculateHeight(
                    mediaQuery, appBar, isInLandscape ? 1.0 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if ((isInLandscape && !isChartEnabled) || !isInLandscape)
              Container(
                height: calculateHeight(
                    mediaQuery, appBar, isInLandscape ? 1.0 : 0.70),
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add)),
    );
  }

  double calculateHeight(
      MediaQueryData mediaQuery, AppBar appBar, double percent) {
    return max(
        (mediaQuery.size.height -
                mediaQuery.padding.top -
                mediaQuery.padding.bottom -
                appBar.preferredSize.height) *
            percent,
        1);
  }
}
