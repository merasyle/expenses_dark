import 'package:flutter/material.dart';
import 'package:meal_app_v101/widgets/transaction_list.dart';

import './models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Dark',
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.greenAccent,
          errorColor: Colors.red
          ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expenses Dark',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black87,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Chart(_recentTransactions)
              ),
              TransactionList(_userTransactions, _removeTransaction)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
