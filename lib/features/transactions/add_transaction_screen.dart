import 'package:expenseflow_firebase_flutter/features/dashboard/dashboard_screen.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_bloc.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_event.dart';
import 'package:expenseflow_firebase_flutter/features/transactions/transaction_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final fK = GlobalKey<FormState>();

  bool? isExpense;
  String? category;
  DateTime selectedDate=DateTime.now();

  final nC = TextEditingController();
  final aC = TextEditingController();

  String? nV(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Enter transaction name";
    }
    return null;
  }

  String? aV(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Enter amount";
    }

    final a = double.tryParse(v);

    if (a == null || a <= 0) {
      return "Enter a valid amount";
    }

    return null;
  }

  String? cV(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Select category";
    }
    return null;
  }

  @override
  void initState() {

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${message.notification!.body}"),
        ),
      );
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {

        if(state.state=="wait"){
          showDialog(context: context, barrierDismissible: false,builder:(context){
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(8),
                  child:
                  Center(child: CircularProgressIndicator(color: Colors.grey))),
            );
          });
        }

        if (state.state == "success") {

          context.read<TransactionBloc>().add(FetchTransaction());

          Navigator.pop(context);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(),
            ),
                (route) => false,
          );
        }

        if (state.state == "failed") {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Transaction failed!! Try Again"),
            ),
          );
        }
      },
      child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Add",style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),

              Text("Transaction",style: TextStyle(color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
            ],
          ),

          Text("Add your income or expense easily",style: TextStyle(color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 15
          ),),
        ],
      ),),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
        key: fK,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 26,),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text("Enter Amount",style: TextStyle(color: Colors.grey,
                        fontSize: 10,
                      )),
                      prefixIcon: Icon(Icons.attach_money,color: Colors.grey,),
                      border: OutlineInputBorder()
                  ),
                  controller: aC,
                  validator: aV,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 4,),
                Text("Enter Amount",style: TextStyle(color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),

                SizedBox(height: 16,),

                Text("Title",style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),

                SizedBox(height: 8,),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text("Enter Title",style: TextStyle(color: Colors.grey,
                        fontSize: 10,
                      )),
                      prefixIcon: Icon(Icons.edit,color: Colors.grey,),
                      border: OutlineInputBorder()
                  ),
                  controller: nC,
                  validator: nV,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

                SizedBox(height: 8,),
                Text("Type",style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),

                SizedBox(height: 8,),
                DropdownButtonFormField(
                    decoration: InputDecoration(
                        label: Text("Select Type",style: TextStyle(color: Colors.grey),
                        ),
                        border: OutlineInputBorder()
                    ),
                    items: [
                  DropdownMenuItem(
                    value: "income",
                    child: Text("Income"),
                  ),
                  DropdownMenuItem(
                    value: "expense",
                    child: Text("Expense"),
                  ),
                ], onChanged: (value){
                  if(value=="income"){
                    isExpense=false;
                  }
                  else{
                    isExpense=true;
                  }
                }),

                SizedBox(height: 8,),

                Text("Category",style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),

                SizedBox(height: 8,),

                DropdownButtonFormField(
                  decoration: InputDecoration(
                    label: Text("Select Category",style: TextStyle(color: Colors.grey),
                    ),
                    border: OutlineInputBorder()
                  ),
                  items: [
                    DropdownMenuItem(
                      value: "food",
                      child: Text("Food & Dining"),
                    ),
                    DropdownMenuItem(
                      value: "groceries",
                      child: Text("Groceries"),
                    ),
                    DropdownMenuItem(
                      value: "shopping",
                      child: Text("Shopping"),
                    ),
                    DropdownMenuItem(
                      value: "transportation",
                      child: Text("Transportation"),
                    ),
                    DropdownMenuItem(
                      value: "fuel",
                      child: Text("Fuel"),
                    ),
                    DropdownMenuItem(
                      value: "bills",
                      child: Text("Bills & Utilities"),
                    ),
                    DropdownMenuItem(
                      value: "rent",
                      child: Text("Rent"),
                    ),
                    DropdownMenuItem(
                      value: "healthcare",
                      child: Text("Healthcare"),
                    ),
                    DropdownMenuItem(
                      value: "education",
                      child: Text("Education"),
                    ),
                    DropdownMenuItem(
                      value: "entertainment",
                      child: Text("Entertainment"),
                    ),
                    DropdownMenuItem(
                      value: "travel",
                      child: Text("Travel"),
                    ),
                    DropdownMenuItem(
                      value: "subscriptions",
                      child: Text("Subscriptions"),
                    ),
                    DropdownMenuItem(
                      value: "personal_care",
                      child: Text("Personal Care"),
                    ),
                    DropdownMenuItem(
                      value: "gifts_donations",
                      child: Text("Gifts & Donations"),
                    ),
                    DropdownMenuItem(
                      value: "salary",
                      child: Text("Salary"),
                    ),
                    DropdownMenuItem(
                      value: "freelance",
                      child: Text("Freelance"),
                    ),
                    DropdownMenuItem(
                      value: "business",
                      child: Text("Business"),
                    ),
                    DropdownMenuItem(
                      value: "investment",
                      child: Text("Investment"),
                    ),
                    DropdownMenuItem(
                      value: "other",
                      child: Text("Other"),
                    ),
                  ],
                  onChanged: (value) {
                    category = value!;
                  },
                ),


                SizedBox(height: 8,),

                Text("Date",style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),



                SizedBox(height: 8,),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  ),
                  decoration: InputDecoration(
                      label: Text("Select Date",style: TextStyle(color: Colors.grey,
                        fontSize: 10,
                      )),
                      prefixIcon: Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                      border: OutlineInputBorder()
                  ),

                  onTap: ()async{
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );

                    if (date != null) {

                        selectedDate = date;
                      }

                  },


                ),


                SizedBox(height: 16,),

                ElevatedButton(onPressed: ()async{
                  if(fK.currentState!.validate() && isExpense!=null && category!=null && selectedDate!=null){
                    context.read<TransactionBloc>().add(AddTransaction(uId: await FirebaseAuth.instance.currentUser!.uid, name: nC.text, isExpense: isExpense!, amount: double.parse(aC.text), date: selectedDate!, category: category!));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Some Fields are not selected or filled")));
                  }
                },
                  style:ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Icon(Icons.add,color: Colors.white,),
                      Text("Add Transaction",style: TextStyle(color: Colors.white,
                        fontSize: 15,
                      )),

                    ],
                  ),),


              ],
            ),
          ),
        ),
      ),
    ));
  }
}
