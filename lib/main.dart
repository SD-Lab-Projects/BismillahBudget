import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:bismillahbudget/screens/login_screen.dart';
import 'package:bismillahbudget/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bismillah Budget',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginViewPage(),
    );
  }
}