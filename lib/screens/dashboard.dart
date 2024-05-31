import 'package:bismillahbudget/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class DashBoard extends StatefulWidget{
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  var isLogoutLoading =false;
  logOut() async {
    setState(() {
      isLogoutLoading =true;
    });
    await FirebaseAuth.instance.signOut();
    Get.to(LoginViewPage());

    setState(() {
      isLogoutLoading =true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                logOut();
          },
              icon:
              isLogoutLoading ? CircularProgressIndicator():
              Icon(Icons.exit_to_app))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Text("Hello",
      ),
    );
  }
}