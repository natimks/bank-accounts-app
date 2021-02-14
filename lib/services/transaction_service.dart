import 'package:debts_app/models/transaction.dart';
import 'package:debts_app/services/account_service.dart';
import 'package:debts_app/utils/db_util.dart';

class TransactionService {
  List<Transaction> _transactionList = [];
  AccountService cs = AccountService();

  void addTransaction(Transaction transaction) {
    DbUtil.insertData('account_transaction', transaction.toMap());
    cs.editBalanceAccount(
        transaction.account, transaction.value, transaction.type);
  }

  Future<List> getAllTransactions() async {
    final dataList = await DbUtil.getData('account_transaction');
    _transactionList = dataList
        .map((transactions) => Transaction.fromMap(transactions))
        .toList();
    return _transactionList;
  }

  Future<List> getTransactionsAccount(int id) async {
    String whereString = "account = ?";
    List<dynamic> whereArguments = [id];
    final dataList = await DbUtil.getDataWhere(
        'account_transaction', whereString, whereArguments);
    return dataList
        .map((transaction) => Transaction.fromMap(transaction))
        .toList();
  }
}
