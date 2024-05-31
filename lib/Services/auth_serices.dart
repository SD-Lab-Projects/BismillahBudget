import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthServices{

  createUser(data,context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
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

