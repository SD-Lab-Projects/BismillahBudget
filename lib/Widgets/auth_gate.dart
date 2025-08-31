/*
import 'package:bismillahbudget/screens/Home_Screen.dart';
import 'package:bismillahbudget/screens/Intro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:bismillahbudget/screens/login_page.dart';
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
          return HomeScreen();
        }
    );//StreamBuilder
  }
}
*/
import 'package:bismillahbudget/screens/Home_Screen.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:flutter/cupertino.dart';
import '../Services/db.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final db = Db();
    return FutureBuilder<int?>(
      future: db.getCurrentUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CupertinoPageScaffold(
            child: Center(child: CupertinoActivityIndicator()),
          );
        }
        final loggedIn = snapshot.data != null;
        if (!loggedIn) {
          return LoginViewPage();
        }
        return const HomeScreen();
      },
    );
  }
}
