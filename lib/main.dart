import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter_02"),
      ),
      body: Center(
        child: Text(
          "Widget playground!",
        ),
      ),
    );
  }
}
