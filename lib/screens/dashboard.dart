import 'package:bismillahbudget/Widgets/Navbar.dart';
import 'package:bismillahbudget/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Home_Screen.dart';
import 'Transaction_Screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var isLogoutLoading = false;
  int currentIndex = 0;
  var pageViewList = [
    HomeScreen(),
    TransactionScreen(),

  ];

  logOut() async {
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
      bottomNavigationBar: Navbar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(Icons.exit_to_app),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: pageViewList[currentIndex],
    );
  }
}
