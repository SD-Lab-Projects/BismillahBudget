import 'package:bismillahbudget/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted successfully')),
      );
      // Redirect to Login page after form submission
      await Future.delayed(Duration(seconds: 2)); // Optional: add a delay to show the snackbar
      Get.off(LoginView()); // Using Get.off to remove the SignUpView from the navigation stack
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF252634),
      ),
      backgroundColor: Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 80.0,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  "Create new account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Username", Icons.person),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Email", Icons.email),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email';
                    }

                    RegExp emailRegExp = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  }),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Phone", Icons.call),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a phone number';
                  }

                  if (value.length != 11) {
                    return 'Please enter an 11 digit phone number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Password", Icons.lock),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }

                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      onPressed: () {
                        _submitForm(context);
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ))),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Get.to(LoginView());
                },
                child: Text(
                  "LOG IN",
                  style: TextStyle(color: Color(0xFFF15900), fontSize: 25),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: Color(0xAA494A59),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0x35949494))),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        filled: true,
        labelStyle: TextStyle(color: Color(0xFF949494)),
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }
}
