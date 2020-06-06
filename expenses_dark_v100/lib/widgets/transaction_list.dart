import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        child: transactions.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: Text('Empty'),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    color: Colors.black12,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                                '\$${transactions[index].amount}',
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 20
                        )
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
