import 'package:expenseflow_firebase_flutter/features/transactions/add_transaction_screen.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_bloc.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_state.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transactions_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../transactions/transaction_event.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
    Colors.grey,
  ];

  final categoriesDb = [
    "food",
    "groceries",
    "shopping",
    "transportation",
    "fuel",
    "bills",
    "rent",
    "healthcare",
    "education",
    "entertainment",
    "travel",
    "subscriptions",
    "personal_care",
    "gifts_donations",
    "salary",
    "freelance",
    "business",
    "investment",
    "other",
  ];

  final categories = [
    "Food & Dining",
    "Groceries",
    "Shopping",
    "Transportation",
    "Fuel",
    "Bills & Utilities",
    "Rent",
    "Healthcare",
    "Education",
    "Entertainment",
    "Travel",
    "Subscriptions",
    "Personal Care",
    "Gifts & Donations",
    "Salary",
    "Freelance",
    "Business",
    "Investment",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Expense",style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
              fontSize: 25
              ),),

              Text("Flow",style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
            ],
          ),

          Text("Manage Smarter, Live Better",style: TextStyle(color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),),
        ],
      ),),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TransactionBloc,TransactionState>(
          builder: (context, state) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            
                SizedBox(height: 8,),
            
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
            
                          Row(
                            children: [
            
                              Text("Total Balance",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),),
            
                              Icon(Icons.attach_money,color: Colors.white,size: 20,)
            
                            ],
                          ),
            
                          Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text("${state.balance}",style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35
                                    ),),
                                  ),
            
            
                            Icon(Icons.account_balance_wallet_outlined,color: Colors.lightGreenAccent,size: 70,)
            
                            ],
                          ),
            
                          Text("Your Financial Snapshot",style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),),
            
                          Divider(color: Colors.lightGreenAccent,),
            
                          Row(
                            children: [

                              Icon(Icons.arrow_upward,color: Colors.white,size: 15,),

                              Text("Total Income",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10
                              ),),

                              Icon(Icons.attach_money,color: Colors.white,size: 15,),

                              Expanded(child: SizedBox()),

                              Icon(Icons.arrow_downward,color: Colors.white,size: 15,),

                              Text("Total Expense",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10
                              ),),

                              Icon(Icons.attach_money,color: Colors.white,size: 15,)

                            ],
                          ),
            
            
                          Row(
                            children: [
                              Expanded(
                                child: Text("${state.income}",style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35
                                ),),
                              ),
            
            
                              Text("${state.expense}",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35
                              ),),
            
                            ],
                          )
            
                        ],
                      ),
                    ),
            
            
            
                SizedBox(height: 26),
            
            
                Text("Transaction Overview",style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),),
            
                SizedBox(height: 8),
            
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
            
                      Expanded(
                        child: Text("Category",style: TextStyle(color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                      ),
            
                      Text("Count",style: TextStyle(color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 15
                      ),),
            
                    ],
                  ),
                ),
            
                Divider(color: Colors.green,),
            
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context,index){

                      int count=0;
                      if(state.transactions!=null) {
                        for (int i = 0; i < state.transactions!.length;i++) {

                          if(state.transactions![i].category==categoriesDb[index]){
                            count++;
                          }

                        }
                      }
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [

                                ClipOval(
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: colors[index]
                                    ),
                                  ),
                                ),

                                SizedBox(width: 8,),

                                Text("${categories[index]}",style: TextStyle(color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),),

                                Expanded(child: SizedBox()),


                                Text("$count",style: TextStyle(color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),),

                              ],
                            ),
                          );
                      }
                )
              ],
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(shape: CircleBorder(),onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionScreen()));
      },child: Icon(Icons.add,color: Colors.white,),

        backgroundColor: Colors.green,


      ),

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Dashboard"),
        BottomNavigationBarItem(icon: Icon(Icons.transfer_within_a_station,),label: "Transaction"),
      ],

        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (i){
        if(i==1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionsScreen()));
        }
        },

      ),

    );
  }
}
