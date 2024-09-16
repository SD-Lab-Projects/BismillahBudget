import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_page.dart';
//the welcome page was changed with a splash screen but the screen was not working so its not impemented onto the main project
class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragStart: (_) {
          Get.to(LoginViewPage());
        },
        child: Container(
          color: Color(0xFF252634),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* Text(
                'BISMILLAH BUDGET',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  fontFamily: 'Montserrat',
                  color: Color(0xFFF15900),
                ),
              ),*/
                Padding(
                  padding: const EdgeInsets.only(
                      left: 80.0, right: 80.0, bottom: 40.0, top: 160.0),
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: const Text(
                    "Swipe to get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
