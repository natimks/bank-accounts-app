import 'package:flutter/material.dart';
import 'package:debts_app/screens/account/components/body.dart';

class AccountScreen extends StatelessWidget {
  final int id;

  AccountScreen({this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        id: id,
      ),
    );
  }
}
