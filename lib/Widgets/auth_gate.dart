import 'package:flutter/cupertino.dart';

import '../screens/dashboard.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return LoginView();
          }
          return DashBoard();
        }
    );//StreamBuilder
  }
}