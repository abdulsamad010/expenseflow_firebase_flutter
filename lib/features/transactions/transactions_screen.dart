import 'package:expenseflow_firebase_flutter/features/transactions/transaction_bloc.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_event.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_transaction_screen.dart' show AddTransactionScreen;

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {


  @override
  void initState() {
    context.read<TransactionBloc>().add(FetchTransaction());

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${message.notification!.body}"),
        ),
      );
    });
    super.initState();
  }


  final colors = [
    Color(0xFF00A844),
    Color(0xFF00B84D),
    Color(0xFF16C45B),
    Color(0xFF2ECC71),
    Color(0xFF43D17A),
    Color(0xFF4CAF50),
    Color(0xFF66BB6A),
    Color(0xFF81C784),
    Color(0xFF003D20),
    Color(0xFF005C2A),
    Color(0xFF007A33),
    Color(0xFF008F3C),
    Color(0xFF8BC34A),
    Color(0xFFA5D66A),
    Color(0xFFB7E08A),
    Color(0xFFC5E8B0),
    Color(0xFFD4F2D2),
    Color(0xFFE3F6E3),
    Color(0xFFF1FAF1),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Tran",style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),

              Text("sactions",style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),

            ],
          ),

          Text("All your income and expenses in one place",style: TextStyle(color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),),
        ],
      ),),

      backgroundColor:const Color(0xFFFFFDF5),

      body: BlocBuilder<TransactionBloc,TransactionState>(


        builder: (context, state) => Padding(
          padding: const EdgeInsets.fromLTRB(0,10,0,10),
          child: SingleChildScrollView(
            child: Column(
              children: [


                state.transactions!=null ?
                ListView.builder(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.transactions!.length,
                    itemBuilder: (context,index){

                      return Container(
                        margin: EdgeInsets.fromLTRB(8,4,8,4),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.01
                            )
                          ],
                            borderRadius: BorderRadius.circular(19),
                          color: Colors.white
                        ),

                        child: Row(
                          children: [

                            Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: colors[index%colors.length]
                              ),

                              child: Icon(Icons.loop,color: Colors.white,size: 30,),
                            ),

                            SizedBox(width: 8,),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text("${state.transactions![index].name}",style: TextStyle(color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18
                                  ),),

                                  Text("${(state.transactions![index].date).toIso8601String().substring(1,10)}",style: TextStyle(color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),),

                                ],
                              ),
                            ),

                            Expanded(child: SizedBox()),



                            state.transactions![index].isExpense ?
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0,0, 20),
                                child: Icon(Icons.minimize,color: Colors.red,size: 33,))
                            : Icon(Icons.add,color: Colors.green,size: 33,),


                            Icon(Icons.currency_rupee,color: Colors.black,),


                            Text("${state.transactions![index].amount}",style: TextStyle(color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                            
                            IconButton(onPressed: (){

                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                 backgroundColor: Colors.white,
                                 title: Center(
                                   child: Text("Are you Sure?",style: TextStyle(color: Colors.black87,
                                       fontWeight: FontWeight.w600,
                                   ),),
                                 ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                        child: Text("To delete the transaction?",style: TextStyle(color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                        ),),
                                      ),


                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.white
                                                ),
                                                onPressed: (){

                                                  Navigator.pop(context);

                                                }, child: Text("No",style: TextStyle(color: Colors.black),)),


                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red
                                                ),
                                                onPressed: (){
                                                  context.read<TransactionBloc>().add(DeleteTransaction(tId:state.transactions![index].tId));
                                                  Navigator.pop(context);
                                                  }, child: Text("Yes",style: TextStyle(color: Colors.white),))

                                          ])


                                    ],
                                  ),





                                );
                              });
                            }, icon: Icon(Icons.delete_outline,color: Colors.red,size: 35,))

                          ],
                        ),
                      );

                }) : Center(
                  child: Text("No Transaction Added",style: TextStyle(color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                ),




              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(shape: CircleBorder(),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionScreen()));
      },child: Icon(Icons.add,color: Colors.white,size: 35,),

        backgroundColor: Colors.green,


      ),
    );
  }
}
