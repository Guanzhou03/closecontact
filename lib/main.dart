import 'package:flutter/material.dart';
import 'package:close_contact/screens/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          backgroundColor: Colors.amber[50],
        ),
        primaryColor: Colors.amber[700],
        fontFamily: 'Proxima',
      ),
      home: const LogIn(),
    );
  }
}
