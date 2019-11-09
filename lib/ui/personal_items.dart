import 'package:flutter/material.dart';
import 'package:personal_expenses/transaction.dart';
import 'package:personal_expenses/ui/personal_single_item.dart';

class PersonalItems extends StatelessWidget {
  PersonalItems(this._transactions, this.deleteTx);

  final List<Transaction> _transactions;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: _transactions.isEmpty
          ? LayoutBuilder(
              builder: (_, constraints) {
                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: const Text(
                        'No transactions yet!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView(
              children: _transactions
                  .map((tx) => PersonalSingleItem(
                        key: ValueKey(tx.id),
                        transaction: tx,
                        deleteTx: deleteTx,
                      ))
                  .toList(),
            ),
    );
  }
}
