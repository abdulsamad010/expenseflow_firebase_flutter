import 'package:expenseflow_firebase_flutter/features/authentication/authentication_bloc.dart';
import 'package:expenseflow_firebase_flutter/features/authentication/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/authentication_event.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterFlow',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: LoginScreen(),
      ),
    );
  }
}
