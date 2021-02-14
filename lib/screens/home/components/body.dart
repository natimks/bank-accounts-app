import 'package:flutter/material.dart';
import 'package:debts_app/screens/components/card_account.dart';
import 'package:debts_app/screens/components/card_transaction.dart';
import 'package:debts_app/screens/transaction/transaction_screen.dart';
import 'package:debts_app/services/account_service.dart';
import 'package:debts_app/services/transaction_service.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AccountService cs = AccountService();
  TransactionService ts = TransactionService();
  Future<List> _loadAccounts;
  Future<List> _loadTransactions;
  List _accounts;
  List _transactions;

  @override
  void initState() {
    // TODO: implement initState
    _loadAccounts = _getContas();
    _loadTransactions = _getTransacoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 175,
            child: FutureBuilder(
              future: _loadAccounts,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _accounts = snapshot.data;
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _accounts.length,
                      padding: EdgeInsets.only(left: 16, right: 8),
                      itemBuilder: (context, index) {
                        return cardAccount(context, _accounts[index]);
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, top: 32, bottom: 16, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Últimas transações",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => TransactionScreen()));
                  },
                  child: Text(
                    "Ver todas",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  ),
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
                        itemCount:
                            _transactions.length > 8 ? 8 : _transactions.length,
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
              }),
        ],
      ),
    );
  }

  Future<List> _getContas() async {
    return await cs.getAllAccounts();
  }

  Future<List> _getTransacoes() async {
    return await ts.getAllTransactions();
  }
}
