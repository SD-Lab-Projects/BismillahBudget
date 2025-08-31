/*
import 'package:bismillahbudget/Services/db.dart';

import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices{
  var db = Db();
  createUser(data,context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      await db.addUser(data, context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => DashBoard())));
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
*/
import 'package:bismillahbudget/Services/db.dart';
import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:flutter/material.dart';

class AuthServices{
  final db = Db();

  Future<void> createUser(Map<String, dynamic> data, BuildContext context) async {
    try {
      await db.createUser(data);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const DashBoard())));
    } catch (e) {
      showDialog(
          context: context,
          builder:  (context) {
            return AlertDialog(
              title: const Text("Sign up Failed"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  Future<void> login(Map<String, dynamic> data, BuildContext context) async {
    try {
      final ok = await db.verifyUser(data['email'], data['password']);
      if (ok) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashBoard()),
        );
      } else {
        showDialog(
            context: context,
            builder:  (context) {
              return const AlertDialog(
                title: Text("Login Error"),
                content: Text("Invalid email or password."),
              );
            }
        );
      }
    } catch (e) {
      showDialog(
          context: context,
          builder:  (context) {
            return AlertDialog(
              title: const Text("Login Error"),
              content: Text(e.toString()),
            );
          }
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await db.clearCurrentUser();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
