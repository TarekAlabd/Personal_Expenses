import 'package:flutter/material.dart';
import 'package:personal_expenses/transaction.dart';
import 'package:personal_expenses/ui/chart.dart';
import 'package:personal_expenses/ui/new_transaction.dart';
import 'package:personal_expenses/ui/personal_items.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transaction> transactions = [
//    Transaction(
//      id: 't1',
//      title: 'New Shoes',
//      amount: 99.99,
//      dateTime: DateTime.now(),
//    ),
//    Transaction(
//      id: 't2',
//      title: 'New bag',
//      amount: 99.99,
//      dateTime: DateTime.now(),
//    ),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
      }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      dateTime: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body: ListView(
        children: <Widget>[
//          Container(
//            width: double.infinity,
//            child: Card(
//              color: Theme.of(context).primaryColor,
//              child: Text("Chart!!",
//              style: TextStyle(
//                color: Colors.white,
//              ),),
//              elevation: 5,
//            ),
//          ),
          Chart(_recentTransactions),
          PersonalItems(transactions, _deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
