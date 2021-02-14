import 'package:debts_app/models/account.dart';
import 'package:debts_app/utils/db_util.dart';

class AccountService {
  List<Account> _accountList = [];

  void addAccount(Account account) {
    DbUtil.insertData('account', account.toMap());
  }

  Future<List> getAllAccounts() async {
    final dataList = await DbUtil.getData('account');
    _accountList = dataList.map((contas) => Account.fromMap(contas)).toList();
    return _accountList;
  }

  Future<Account> getAccount(int id) async {
    String whereString = "id = ?";
    List<dynamic> whereArguments = [id];
    final dataList =
        await DbUtil.getDataWhere('account', whereString, whereArguments);
    return Account.fromMap(dataList.first);
  }

  void editBalanceAccount(int id, double value, int transactionType) {
    String operation = transactionType == 1 ? '+' : '-';
    String sql =
        'UPDATE account SET balance = balance $operation ? WHERE id = ?';

    List<dynamic> arguments = [value, id];
    DbUtil.executeSQL(sql, arguments);
  }
}
