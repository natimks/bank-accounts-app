import 'package:debts_app/models/account.dart';
import 'package:debts_app/services/account_service.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _balanceController = TextEditingController();
  final AccountService accountService = new AccountService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cadastro de conta"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Título'),
                controller: _titleController,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Saldo'),
                controller: _balanceController,
              ),
              Padding(
                padding: EdgeInsets.only(top: 18, bottom: 24),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      Account newAccount = Account(
                        title: _titleController.text,
                        balance: double.parse(_balanceController.text),
                      );
                      accountService.addAccount(newAccount);
                    },
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          )),
        )));
  }
}
