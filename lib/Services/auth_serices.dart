import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthServices{

  createUser(data,context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginViewPage()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder:  (context) {
            return AlertDialog(
              title: Text("Sign up Failed"),
              content: Text(e.toString()),
            );
        }
      );
    }
  }

login(data,context) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: data['email'],
      password: data['password'],
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashBoard()),
    );
  } catch (e) {
    showDialog(
        context: context,
        builder:  (context) {
          return AlertDialog(
            title: Text("Login Error"),
            content: Text(e.toString()),
          );
        }
    );
  }
}
}

