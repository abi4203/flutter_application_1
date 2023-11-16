import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/expenseCalculator.dart';
import 'package:flutter_application_1/pages/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task',
      theme: ThemeData(
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/todo': (context) => const Todo(title: 'Task'),
        '/expense-tracker': (context) => ExpenseCalculatorApp(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/todo');
              },
              child: Text('TO-DO')),
              SizedBox(
                height: 10,
              ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/expense-tracker');
              },
              child: Text('Expense Tracker')),
        ],
      ),
    );
  }
}
