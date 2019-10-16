import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/transaction.dart';

class PersonalItems extends StatelessWidget {
  PersonalItems(this._transactions, this.deleteTx);

  final List<Transaction> _transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _transactions.isEmpty ? Column(children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'No transactions yet!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 200,
          child: Image.asset('assets/images/waiting.png',
          fit: BoxFit.cover,),
        ),
      ],) : ListView.builder(
          itemCount: _transactions.length,
          itemBuilder: (_, int index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: FittedBox(
                      child: Text(
                        _transactions[index].amount.toStringAsFixed(2),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  _transactions[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(_transactions[index].dateTime),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTx(_transactions[index].id),
                ),
              ),
            );
          }),
    );
  }
}
