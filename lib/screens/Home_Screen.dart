import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Widgets/herocard.dart';
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: isLogoutLoading
                  ? CircularProgressIndicator()
                  : Icon(Icons.exit_to_app))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          HeroCard(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  "Recent Transaction",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


