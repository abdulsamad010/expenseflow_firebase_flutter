class TransactionModel {
  String name,tId,uId,category;
  bool isExpense;
  double amount;
  DateTime date;
  TransactionModel({required this.tId,required this.uId,required this.name,required this.isExpense,required this.amount,required this.date,required this.category});

  Map<String, dynamic> toMap() {
    return {
      "tId":tId,
      "name": name,
      "amount": amount,
      "isExpense": isExpense,
      "category": category,
      "date": date,
      "uId": uId,
    };
  }

}