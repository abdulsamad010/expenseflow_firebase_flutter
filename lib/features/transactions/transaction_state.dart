import 'package:expenseflow_firebase_flutter/core/models/transaction_model.dart';

class TransactionState {
  final List<TransactionModel>? transactions;
  final String? state;
  final String user_name,user_email;
  final double balance,income,expense;

  TransactionState({this.user_email="@gmail.com",this.transactions,this.state,this.balance=0,this.expense=0,this.user_name="User",this.income=0});

}