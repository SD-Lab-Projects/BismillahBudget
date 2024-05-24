import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{

  createUser(data,context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
    } catch (e) {
      print(e);
    }
  }

}