import 'package:bismillahbudget/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';



class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return LoginViewPage();
          }
          return DashBoard();
        }
    );//StreamBuilder
  }
}