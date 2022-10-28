import 'package:flutter/material.dart';
import 'package:flutter_02/transaction.dart';

void main() {
  runApp(MyApp());
}

///
/// @author Paweł Drelich <drelich_pawel@o2.pl>
///
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_02',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: "1", title: "title1", amount: 1.99, date: DateTime.now()),
    Transaction(id: "2", title: "title2", amount: 2.99, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter_02"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              child: Text(
                "CHART!",
              ),
            ),
            elevation: 5,
          ),
          Card(
            color: Colors.red,
            elevation: 5,
            child: Text(
              "List of TX!",
            ),
          ),
        ],
      ),
    );
  }
}
