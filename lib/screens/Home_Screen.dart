import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  var isLogoutLoading = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;

  logout() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    // Get.to(LoginViewPage());
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));

    setState(() {
      // isLogoutLoading = true;
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        body: Container(
            width: double.infinity,
            color: Colors.blue.shade900,
            child: Column(
              children: [
                Column(

                Container(
                color: Colors.white,
                child: Row(
                  children: [

                  ],
                ),
              ))],
            )),
      ),
    );
  }
}
