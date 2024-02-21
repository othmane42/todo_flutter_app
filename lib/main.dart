
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:todo/models/item.dart';
import 'package:todo/services/databaseClient.dart';
import 'package:todo/screens/home_page.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'My Todo App'),
      debugShowCheckedModeBanner: false,
    );
  }
}