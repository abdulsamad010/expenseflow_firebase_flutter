import 'package:expenseflow_firebase_flutter/features/authentication/authentication_bloc.dart';
import 'package:expenseflow_firebase_flutter/features/authentication/login_screen.dart';
import 'package:expenseflow_firebase_flutter/features/dashboard/dashboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/authentication_event.dart';
import 'features/transactions/transaction_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user=await FirebaseAuth.instance.currentUser;

  await FirebaseMessaging.instance.requestPermission(
    alert:true,
    badge: true,
    sound: true,
  );

  final token=await FirebaseMessaging.instance.getToken();
  print("Token: $token");

  await FirebaseMessaging.instance.subscribeToTopic("expenseflow_users");

  runApp(MyApp(user:user));
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({super.key,this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(),),
        BlocProvider(create: (context) => TransactionBloc(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterFlow',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: user!=null ? DashboardScreen() : LoginScreen(),
      ),
    );
  }
}
