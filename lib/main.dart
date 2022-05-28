import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Login Screen';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          backgroundColor: Colors.amber[50],
        ),
        primaryColor: Colors.amber[700],
        fontFamily: 'Proxima',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(_title),
        ),
        body: const LogIn(),
      ),
    );
  }
}
