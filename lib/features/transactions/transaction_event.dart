abstract class TransactionEvent {
}

class AddTransaction extends TransactionEvent{
  final String name,uId,category;
  final bool isExpense;
  final double amount;
  final DateTime date;
  AddTransaction({required this.uId,required this.name,required this.isExpense,required this.amount,required this.date,required this.category});
}

class DeleteTransaction extends TransactionEvent{
  final String tId;
  DeleteTransaction({required this.tId});
}

class FetchTransaction extends TransactionEvent{
  FetchTransaction();
}