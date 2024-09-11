import 'package:bismillahbudget/Widgets/Navbar.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:bismillahbudget/screens/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final pageViewList = [
    const HomeScreen(),
    const TransactionScreen(),
    ProfilePage(),
  ];

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginViewPage()));
    setState(() {
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
      /*appBar: AppBar(
        actions: [
          IconButton(
            onPressed: logOut,
            icon: isLogoutLoading
                ? Center(child: CircularProgressIndicator())
                : const Icon(Icons.exit_to_app),
          )
        ],
        automaticallyImplyLeading: false,
      ),*/
      body: pageViewList[currentIndex],
    );
  }
}
