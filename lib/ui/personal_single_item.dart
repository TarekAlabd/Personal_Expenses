import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/transaction.dart';

class PersonalSingleItem extends StatefulWidget {
  const PersonalSingleItem({Key key, @required this.transaction, @required this.deleteTx})
      : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _PersonalSingleItemState createState() => _PersonalSingleItemState();
}

class _PersonalSingleItemState extends State<PersonalSingleItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _bgColor,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text(
                      '\$${widget.transaction.amount.toStringAsFixed(2)}',
                    ),
                  ),
                ),
              ),
              title: Text(
                widget.transaction.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(widget.transaction.dateTime),
              ),
              trailing: MediaQuery.of(context).size.width > 460
                  ? FlatButton.icon(
                      onPressed: () =>
                          widget.deleteTx(widget.transaction.id),
                      icon: const Icon(Icons.delete),
                      textColor: Theme.of(context).errorColor,
                      label: const Text('Delete'))
                  : IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          widget.deleteTx(widget.transaction.id),
                    ),
            ),
          );
  }
}
