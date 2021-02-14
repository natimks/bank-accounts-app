import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:debts_app/screens/create_account/create_account_screen.dart';
import 'package:debts_app/screens/create_transaction/create_transaction_screen.dart';

SpeedDial buildSpeedDial(BuildContext context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    animatedIconTheme: IconThemeData(size: 22),
    children: [
      SpeedDialChild(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CreateTransactionScreen(
                      typeTransaction: 1,
                    )));
          },
          label: "Entrada",
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.green),
      SpeedDialChild(
          child: Icon(
            Icons.remove,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CreateTransactionScreen(
                      typeTransaction: 2,
                    )));
          },
          label: "Saída",
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.red),
      SpeedDialChild(
          child: Icon(
            Icons.account_balance,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CreateAccountScreen()));
          },
          label: "Conta",
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.blue),
    ],
  );
}
