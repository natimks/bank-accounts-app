class Account {
  int id;
  String title;
  double balance;
  Account({this.id, this.title, this.balance});
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'balance': balance};
  }

  Account.fromMap(Map map) {
    id = map["id"];
    title = map["title"];
    balance = map["balance"];
  }
}
