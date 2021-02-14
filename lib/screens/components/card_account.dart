import 'package:flutter/material.dart';
import 'package:debts_app/models/account.dart';
import 'package:debts_app/screens/account/account_screen.dart';
import 'package:debts_app/utils/number_format.dart';

Widget cardAccount(BuildContext context, Account account) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AccountScreen(
                id: account.id,
              )));
    },
    child: Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.deepPurpleAccent,
          boxShadow: [
            BoxShadow(
                color: Color(0x100000),
                blurRadius: 10,
                spreadRadius: 4,
                offset: Offset(0.0, 8.0))
          ]),
      child: Stack(
        children: [
          Positioned(
            top: 14,
            right: 12,
            child: Text(
              account.title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: 63,
            left: 16,
            child: Text(
              'Saldo em conta',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          Positioned(
            top: 81,
            left: 16,
            child: Text(NumberFormater.formatCurrency(account.balance),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white)),
          )
        ],
      ),
    ),
  );
}
