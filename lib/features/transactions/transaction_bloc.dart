import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseflow_firebase_flutter/core/models/transaction_model.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_event.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
  TransactionBloc() : super(TransactionState()){

    on<AddTransaction>((event,emit) async {

      emit(TransactionState(
        state: "wait",
      ));

      try {

        final doc=await FirebaseFirestore.instance.collection("users").doc("transactions").collection(FirebaseAuth.instance.currentUser!.uid).doc();
        TransactionModel tM=TransactionModel(tId: doc.id, uId: event.uId, name: event.name, isExpense: event.isExpense, amount: event.amount, date: event.date, category: event.category);

        await doc.set(tM.toMap());

        emit(TransactionState(
          state: "success",
        ));

      }
      catch(exception){
        print("Error: $exception");
        emit(TransactionState(
          state: "failed",
        ));
      }


    });


    on<DeleteTransaction>((event,emit) async {

      emit(TransactionState(
        state: "wait",
      ));

      try {

        await FirebaseFirestore.instance.collection("users").doc("transactions").collection(FirebaseAuth.instance.currentUser!.uid).doc(event.tId).delete();

        emit(TransactionState(
          state: "success",
        ));

      }
      catch(exception){
        emit(TransactionState(
          state: "failed",
        ));
      }


    });

    on<FetchTransaction>((event,emit) async {

      emit(TransactionState(
        state: "sending",
      ));

      try {

        final transactions1=await FirebaseFirestore.instance.collection("users").doc("transactions").collection(FirebaseAuth.instance.currentUser!.uid).get();

        List<TransactionModel> transactions2=[];
        
        for(int i=0;i<transactions1.docs.length;i++){
          TransactionModel transactions3=TransactionModel(tId: transactions1.docs[i]["tId"], uId:transactions1.docs[i]["uId"], name: transactions1.docs[i]["name"], isExpense: transactions1.docs[i]["isExpense"], amount: (transactions1.docs[i]["amount"] as num).toDouble(), date: (transactions1.docs[i]["date"] as Timestamp).toDate() , category: transactions1.docs[i]["category"]);
          transactions2.add(transactions3);
        }

        emit(TransactionState(
          transactions: transactions2,
          state: "success",
        ));

      }
      catch(exception){
        emit(TransactionState(
          state: "failed",
        ));
      }


    });


  }
}