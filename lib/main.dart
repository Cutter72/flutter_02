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
  final List<Transaction> _transactions = [
    Transaction(id: "1", title: "title1", amount: 1.99, date: DateTime.now()),
    Transaction(id: "2", title: "title2", amount: 2.9, date: DateTime.now()),
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
          Column(
            children: _transactions.map((tx) {
              return Card(
                elevation: 5,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          border: Border.all(color: Colors.purple, width: 2)),
                      child: Text(
                        maxLines: 1,
                        style: TextStyle(color: Colors.purple, fontSize: 18, fontWeight: FontWeight.bold),
                        "\$${tx.amount}",
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          child: Text(
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                            tx.title.toUpperCase(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          child: Text(
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            "Date: ${tx.date.toLocal().toString()}",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
