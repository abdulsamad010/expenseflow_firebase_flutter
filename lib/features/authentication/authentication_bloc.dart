import 'package:expenseflow_firebase_flutter/features/authentication/authentication_event.dart';
import 'package:expenseflow_firebase_flutter/features/authentication/authentication_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{

  AuthenticationBloc() : super(AuthenticationState()){
    on<Signup>((event,emit) async {

      emit(AuthenticationState(
        state: "wait"
      )
      );

      try {

        final credential=await FirebaseAuth.instance.createUserWithEmailAndPassword(
          password: event.password,
          email: event.email,
        );

        emit(AuthenticationState(
          email: event.email,
          state: "success",
          uId: credential.user!.uid,
        ));

      }
      catch(exception){
        emit(AuthenticationState(
          state: "failed"
        ));
      }


    });



    on<Login>((event,emit) async {

      emit(AuthenticationState(
          state: "wait"
      )
      );

      try {

        final credential=await FirebaseAuth.instance.signInWithEmailAndPassword(
          password: event.password,
          email: event.email,
        );

        emit(AuthenticationState(
          email: event.email,
          state: "success",
          uId: credential.user!.uid,
        ));

      }
      catch(exception){
        emit(AuthenticationState(
            state: "failed"
        ));
      }
    });




    on<Obscure>((event,emit) {

      emit(AuthenticationState(
          obscure: !state.obscure
      )
      );});




   }
  }