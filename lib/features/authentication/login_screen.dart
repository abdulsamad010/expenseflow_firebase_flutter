import 'package:expenseflow_firebase_flutter/features/authentication/authentication_bloc.dart';
import 'package:expenseflow_firebase_flutter/features/authentication/authentication_state.dart';
import 'package:expenseflow_firebase_flutter/features/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dashboard/dashboard_screen.dart';
import 'authentication_event.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  Icon visile=Icon(Icons.remove_red_eye_outlined,color: Colors.grey);
  Icon nonVisible=Icon(Icons.password,color: Colors.grey,);
  late Icon icon=visile;

  final fK=GlobalKey<FormState>();
  final eC=TextEditingController();
  final pC=TextEditingController();


  String? eV(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Enter a valid email";
    }

    if (!v.contains("@") || !v.contains(".")) {
      return "Enter a valid email";
    }

    return null;
  }

  String? pV(String? v) {
    if (v == null || v.trim().isEmpty) {
      return "Enter password";
    }

    if (v.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocListener<AuthenticationBloc,AuthenticationState>(
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

            if (state.state == "failed") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Signup failed"),
                ),
              );
            }

            if (state.state == "success") {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Signup Successful"),
                ),
              );
            }

            if(state.state=="success"){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>DashboardScreen()),(route) {
                return false;
              },);
            }

            if (state.state == "failed") {
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0,8,8,8),
            child: Form(
              key: fK,
              child: Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 20,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Welcome Back",style: TextStyle(color: Colors.grey,
                            fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.right,),

                            Icon(Icons.waving_hand_outlined,color: Colors.orangeAccent,size: 35,)
                          ],
                        ),

                        Expanded(child: SizedBox()),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Expense",style: TextStyle(color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            )),
                            Text("Flow",style: TextStyle(color: Colors.green,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ))
                          ],
                        ),

                        SizedBox(height: 8,),

                        Center(child: Icon(Icons.account_balance_wallet_outlined,color: Colors.green,size: 55,)),

                        SizedBox(height: 16,),

                        Text("Login to your account",style: TextStyle(color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),

                        SizedBox(height: 4,),

                        Text("Continue your journey to better money management",style: TextStyle(color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),

                        SizedBox(height: 16,),

                        TextFormField(
                          decoration: InputDecoration(
                            label: Text("Enter Email",style: TextStyle(color: Colors.grey,
                              fontSize: 10,
                            )),
                            prefixIcon: Icon(Icons.mail,color: Colors.grey,),
                            border: OutlineInputBorder()
                          ),
                          controller: eC,
                          validator: eV,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),

                        SizedBox(height: 8,),

                        BlocBuilder<AuthenticationBloc,AuthenticationState>(
                          builder: (context, state) => TextFormField(
                            decoration: InputDecoration(
                                label: Text("Enter Password",style: TextStyle(color: Colors.grey,
                                  fontSize: 10,
                                )),
                                prefixIcon: Icon(Icons.lock,color: Colors.grey,),
                                border: OutlineInputBorder(),
                              suffixIcon: IconButton(onPressed: (){
                                if(icon==visile){
                                  icon=nonVisible;
                                }
                                else{
                                  icon=visile;
                                }
                                context.read<AuthenticationBloc>().add(Obscure());
                              }, icon: icon,),
                            ),
                            obscureText: state.obscure,
                            controller: pC,
                            validator: pV,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                          ),
                        ),

                        SizedBox(height: 16,),

                        ElevatedButton(onPressed: (){
                          if(fK.currentState!.validate()){
                            context.read<AuthenticationBloc>().add(Login(email: eC.text, password: pC.text));
                          }
                        },
                          style:ElevatedButton.styleFrom(
                            backgroundColor: Colors.green
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.arrow_forward,color: Colors.white,),
                            Text("Login",style: TextStyle(color: Colors.white,
                              fontSize: 15,
                            )),

                          ],
                        ),),

                        SizedBox(height: 8,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",style: TextStyle(color: Colors.grey,
                              fontSize: 10,
                            )),

                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                            }, child: Text("Signup",style: TextStyle(color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            )),)
                          ],
                        ),

                        Expanded(child: SizedBox()),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
