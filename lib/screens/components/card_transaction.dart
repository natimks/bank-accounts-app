import 'package:date_format/date_format.dart';
import 'package:debts_app/utils/number_format.dart';
import 'package:flutter/material.dart';
import 'package:debts_app/models/transaction.dart';

Widget cardTransaction(
    BuildContext context, int index, Transaction transaction) {
  return Container(
    margin: EdgeInsets.only(bottom: 8, left: 10, right: 10),
    height: 68,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
            color: Color(0x0400000),
            blurRadius: 10,
            spreadRadius: 10,
            offset: Offset(0.0, 8.0)),
      ],
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  transaction.title,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: transaction.type == 1 ? Colors.green : Colors.red),
                ),
                Text(
                  transaction.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  NumberFormater.formatCurrency(transaction.value),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey),
                ),
                Text(
                  formatDate(DateTime.parse(transaction.transactionDate),
                      [dd, '/', mm, '/', yyyy]).toString(),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            )
          ],
        )
      ],
    ),
  );
}
