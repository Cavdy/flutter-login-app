import 'package:flutter/material.dart';
import 'package:loginapp/root_page.dart';
import 'package:loginapp/authentication.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: RootPage(auth: Auth(),),
    );
  }
}