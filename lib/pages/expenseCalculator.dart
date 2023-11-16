import 'package:flutter/material.dart';

class ExpenseCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Calculator',
      home: ExpenseCalculatorScreen(),
    );
  }
}

class Transaction {
  String category;
  double amount;

  Transaction(this.category, this.amount);
}

class ExpenseCalculatorScreen extends StatefulWidget {
  @override
  _ExpenseCalculatorScreenState createState() =>
      _ExpenseCalculatorScreenState();
}

class _ExpenseCalculatorScreenState extends State<ExpenseCalculatorScreen> {
  final List<Transaction> expenses = [];
  final List<Transaction> income = [];
  final TextEditingController expenseCategoryController =
      TextEditingController();
  final TextEditingController expenseAmountController = TextEditingController();
  final TextEditingController incomeCategoryController =
      TextEditingController();
  final TextEditingController incomeAmountController = TextEditingController();
  double totalExpense = 0.0;
  double totalIncome = 0.0;

  void addExpense() {
    final String category = expenseCategoryController.text;
    final double amount = double.tryParse(expenseAmountController.text) ?? 0.0;

    if (category.isNotEmpty && amount > 0) {
      setState(() {
        expenses.add(Transaction(category, amount));
        totalExpense += amount;
      });
      expenseCategoryController.clear();
      expenseAmountController.clear();
    }
  }

  void addIncome() {
    final String category = incomeCategoryController.text;
    final double amount = double.tryParse(incomeAmountController.text) ?? 0.0;

    if (category.isNotEmpty && amount > 0) {
      setState(() {
        income.add(Transaction(category, amount));
        totalIncome += amount;
      });
      incomeCategoryController.clear();
      incomeAmountController.clear();
    }
  }

  double calculateBalance() {
    return totalIncome - totalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Calculator'),
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            icon: Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Expenses:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildTransactionList(expenses),
            Text(
              'Total Expense: \$$totalExpense',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Income:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            buildTransactionList(income),
            Text(
              'Total Income: \$$totalIncome',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Balance:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Balance: \$$totalIncome - \$$totalExpense = \$${calculateBalance()}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Add Expense:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: expenseCategoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: expenseAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            ElevatedButton(
              onPressed: addExpense,
              child: Text('Add Expense'),
            ),
            SizedBox(height: 20),
            Text(
              'Add Income:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: incomeCategoryController,
              decoration: InputDecoration(labelText: 'Source'),
            ),
            TextField(
              controller: incomeAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            ElevatedButton(
              onPressed: addIncome,
              child: Text('Add Income'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransactionList(List<Transaction> transactions) {
    return Column(
      children: transactions.map((tx) {
        return Card(
          child: ListTile(
            title: Text(tx.category),
            subtitle: Text('\$${tx.amount.toStringAsFixed(2)}'),
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    expenseCategoryController.dispose();
    expenseAmountController.dispose();
    incomeCategoryController.dispose();
    incomeAmountController.dispose();
    super.dispose();
  }
}
