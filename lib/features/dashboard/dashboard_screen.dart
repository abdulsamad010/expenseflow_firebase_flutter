import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseflow_firebase_flutter/features/authentication/login_screen.dart';
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



    DateTime date=DateTime.now();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,title: Column(
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

              Expanded(child: SizedBox()),

              Padding(
                padding: const EdgeInsets.fromLTRB(0,19.0,0,0),
                child: Text("${date.toString().substring(0,10)}",style: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 15
                ),),
              )
            ],
          ),

          Text("Manage Smarter, Live Better",style: TextStyle(color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),),
        ],
      ),),

      endDrawer: SafeArea(
        child: BlocBuilder<TransactionBloc,TransactionState>(
            builder: (context, state) =>Drawer(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0,32,8,8),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 70,
                  child: Icon(Icons.perm_identity,size: 100,color: Colors.green,),
                ),

             SizedBox(height: 8,),

             Text("${state.user_name}",style: TextStyle(
               fontSize: 25,
               fontWeight: FontWeight.bold
             ),),


                SizedBox(height: 12,),

                Text("${state.user_email}",style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                ),),

                SizedBox(height: 12,),



                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                  },

                  leading: Icon(Icons.home,color: Colors.green,size: 35,),
                  title: Text("Home",style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),),
                ),

                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTransactionScreen()));
                  },

                  leading: Icon(Icons.add_circle_rounded,color: Colors.green,size: 35,),
                  title: Text("Add Transaction",style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),),
                ),

                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionsScreen()));
                  },

                  leading: Icon(Icons.transfer_within_a_station,color: Colors.green,size: 35,),
                  title: Text("View Transactions",style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),),
                ),




                ListTile(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Center(
                          child: Text("About App",style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                        
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "ExpenseFlow is a simple and intuitive expense management app designed to help you keep track of your daily finances. "
                                  "You can record your income and expenses, organize transactions, monitor your balance, and stay informed about your financial activity. "
                                  "With Firebase integration, ExpenseFlow provides secure authentication, cloud-based data storage, and timely notifications to help you stay on top of your finances.",
                              style: const TextStyle(
                                fontSize: 15,
                                height: 1.6,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 12,),
                            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text("OK"))
                          ],
                        ),
                      );
                    });
                  },
                  
                  leading: Icon(Icons.info,color: Colors.green,size: 35,),
                title: Text("About App",style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),),
                ),







                Expanded(child: SizedBox()),

                ListTile(
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Center(
                          child: Text("Are you sure to LogOut?",style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),),
                        ),


                          content: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: ()async{
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false,);
                          }, child: Text("Yes",style: TextStyle(color: Colors.white),))

                      );
                    });
                  },

                  leading: Icon(Icons.logout,color: Colors.red,size: 35,),
                  title: Text("LogOut",style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),),
                ),

              ],
            ),
          ),
        )),
      ),
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
                                  fontStyle: FontStyle.italic,
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
                                        fontStyle: FontStyle.italic,
                                        fontSize: 35
                                    ),),
                                  ),


                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                      child: Image.asset("assets/logo.png",width: 100,))
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
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10
                              ),),

                              Icon(Icons.attach_money,color: Colors.white,size: 15,),

                              Expanded(child: SizedBox()),

                              Icon(Icons.arrow_downward,color: Colors.white,size: 15,),

                              Text("Total Expense",style: TextStyle(color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
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


                                count!=0?
                                Text("$count",style: TextStyle(color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15
                                ),): Text("No Transaction",style: TextStyle(color: Colors.grey,
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
