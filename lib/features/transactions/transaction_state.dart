import 'package:expenseflow_firebase_flutter/core/models/transaction_model.dart';

class TransactionState {
  final List<TransactionModel>? transactions;
  final String? state;
  TransactionState({this.transactions,this.state});

}