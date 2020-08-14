import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList({this.transactions, this.deleteTransaction});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 370,
        // child: SingleChildScrollView(
        child: transactions.isEmpty
            ? (LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/noexpenses.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'No transactions added yet',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                );
              }))
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, idx) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: FittedBox(
                                  child: Text(
                                '\$${transactions[idx].amount}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )))),
                      title: Text(transactions[idx].title,
                          style: Theme.of(context).textTheme.title),
                      subtitle: Text(
                          DateFormat.yMMMd().format(transactions[idx].date)),
                      trailing: MediaQuery.of(context).size.width > 460
                          ? FlatButton.icon(
                              icon: Icon(Icons.delete),
                              label: Text('Delete'),
                              textColor: Theme.of(context).errorColor,
                              onPressed: () {
                                deleteTransaction(transactions[idx].id);
                              })
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                deleteTransaction(transactions[idx].id);
                              }),
                    ),
                  );
                }));
  }
  // children: transactions
  //     .map((item) => Card(
  //             child: Row(
  //           children: <Widget>[
  //             Container(
  //               padding: EdgeInsets.all(10),
  //               margin:
  //                   EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.purple, width: 2)),
  //               child: Text(
  //                 "\$${item.amount}",
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 20,
  //                     color: Colors.purple),
  //               ),
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   item.title,
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold, fontSize: 16),
  //                 ),
  //                 Text(
  //                   DateFormat().add_yMMMd().format(item.date),
  //                   style: TextStyle(color: Colors.grey),
  //                 )
  //               ],
  //             )
  //           ],
  //         )))
  //     .toList(),
  // );
}
