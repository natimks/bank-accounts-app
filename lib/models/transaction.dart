class Transaction {
  int id, type, account;
  String title, description, transactionDate;
  double value;

  Transaction(
      {this.id,
      this.type,
      this.account,
      this.title,
      this.description,
      this.transactionDate,
      this.value});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'account': account,
      'title': title,
      'description': description,
      'transactionDate': transactionDate,
      'value': value,
    };
  }

  Transaction.fromMap(Map map) {
    id = map["id"];
    type = map["type"];
    account = map["account"];
    title = map["title"];
    description = map["description"];
    transactionDate = map["transactionDate"];
    value = map["value"];
  }
}
