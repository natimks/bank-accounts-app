import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:debts_app/models/account.dart';
import 'package:debts_app/models/transaction.dart';
import 'package:debts_app/screens/home/home_screen.dart';
import 'package:debts_app/services/account_service.dart';
import 'package:debts_app/services/transaction_service.dart';

class CreateTransactionScreen extends StatefulWidget {
  final int typeTransaction;

  CreateTransactionScreen({this.typeTransaction});
  @override
  _CreateTransactionScreenState createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  final _dateController = TextEditingController();
  Account _selectedAccount;
  AccountService cs = AccountService();
  Future<List> _loadContas;
  List<Account> _contas;
  DateTime selectedDate = DateTime.now();
  TransactionService ts = TransactionService();

  @override
  void initState() {
    // TODO: implement initState
    _loadContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.typeTransaction == 1
            ? "Cadastro de entrada"
            : "Cadastro de saída"),
        backgroundColor:
            widget.typeTransaction == 1 ? Colors.green : Colors.red,
      ),
      body: FutureBuilder(
        future: _loadContas,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            _contas = snapshot.data;
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Título"),
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(labelText: "Descrição"),
                      ),
                      TextFormField(
                        controller: _valueController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Valor"),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _dateController,
                            decoration: InputDecoration(
                              labelText: formatDate(
                                  selectedDate, [dd, '/', mm, '/', yyyy]),
                            ),
                          ),
                        ),
                      ),
                      DropdownButtonFormField(
                        value: _selectedAccount,
                        onChanged: (Account account) {
                          setState(() {
                            _selectedAccount = account;
                          });
                        },
                        items: _contas.map((conta) {
                          return DropdownMenuItem<Account>(
                            value: conta,
                            child: Text(conta.title),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          child: RaisedButton(
                            onPressed: () {
                              Transaction newTransaction = Transaction(
                                  title: _titleController.text,
                                  description: _descriptionController.text,
                                  type: widget.typeTransaction,
                                  value: double.parse(_valueController.text),
                                  transactionDate: selectedDate.toString(),
                                  account: _selectedAccount.id);
                              ts.addTransaction(newTransaction);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => HomeScreen()));
                            },
                            color: widget.typeTransaction == 1
                                ? Colors.green
                                : Colors.red,
                            child: Text(
                              "Cadastrar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2018, 01),
        lastDate: DateTime(2030, 01));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<List> _getContas() async {
    return await cs.getAllAccounts();
  }
}
