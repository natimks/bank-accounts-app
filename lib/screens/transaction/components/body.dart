import 'package:flutter/material.dart';
import 'package:debts_app/models/transaction.dart';
import 'package:debts_app/screens/components/card_transaction.dart';
import 'package:debts_app/services/transaction_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TransactionService ts = TransactionService();
  Future<List> _loadTransactions;
  List<Transaction> _transactions;

  @override
  void initState() {
    _loadTransactions = _getTransactions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 60, top: 67, bottom: 16, right: 24),
          child: Row(
            children: [
              Text(
                "Todas as transações",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black),
              )
            ],
          ),
        ),
        FutureBuilder(
          future: _loadTransactions,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _transactions = snapshot.data;
              return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _transactions.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return cardTransaction(
                          context, index, _transactions[index]);
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ],
    );
  }

  Future<List> _getTransactions() async {
    return await ts.getAllTransactions();
  }
}
