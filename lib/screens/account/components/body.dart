import 'package:flutter/material.dart';
import 'package:debts_app/models/account.dart';
import 'package:debts_app/models/transaction.dart';
import 'package:debts_app/screens/components/card_account.dart';
import 'package:debts_app/screens/components/card_transaction.dart';
import 'package:debts_app/services/account_service.dart';
import 'package:debts_app/services/transaction_service.dart';

class Body extends StatefulWidget {
  final int id;

  Body({this.id});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TransactionService ts = TransactionService();
  AccountService cs = AccountService();
  Future<List> _loadTransactions;
  Future<Account> _loadAccount;
  List<Transaction> _transactions;
  Account _account;

  @override
  void initState() {
    _loadTransactions = _getTransactions(widget.id);
    _loadAccount = _getAccount(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 67, bottom: 16),
          child: Container(
            height: 175,
            width: double.infinity,
            child: FutureBuilder(
              future: _loadAccount,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _account = snapshot.data;
                  return cardAccount(context, _account);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Todas as transações",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: _loadTransactions,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _transactions = snapshot.data;
              if (_transactions.length == 0) {
                return Image(image: AssetImage('lib/assets/not_found.png'));
              }
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

  Future<List> _getTransactions(int id) async {
    return await ts.getTransactionsAccount(id);
  }

  Future<Account> _getAccount(int id) async {
    return await cs.getAccount(id);
  }
}
