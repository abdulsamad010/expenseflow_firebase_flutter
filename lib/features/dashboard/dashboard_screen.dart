import 'package:expenseflow_firebase_flutter/features/transactions/add_transaction_screen.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transactions_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Column(
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
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
                          children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("24850",style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35
                                ),),

                                Text("Your Financial Snapshot",style: TextStyle(color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                              ],
                            ),
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.account_balance_wallet_outlined,color: Colors.lightGreenAccent,size: 70,),

                            ],
                          )

                          ],
                        ),

                        Text("${FirebaseAuth.instance.currentUser!.uid}"),
                      ],
                    ),
                  )

                ],
              ),
            ),

          ],
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
        BottomNavigationBarItem(icon: Icon(Icons.home,),label: "Transaction"),
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
