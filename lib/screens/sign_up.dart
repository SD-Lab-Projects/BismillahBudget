import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';

class SignUp_view extends StatelessWidget {
  SignUp_view({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //get child => null;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(_formKey.currentState! as BuildContext).showSnackBar(
          const SnackBar(content: Text('Form Submitted successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Username", Icons.person),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter a username';
                  }
                  return null;
                },
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
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    );
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }

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

                  if (value.length != 10) {
                    return 'Please enter a 10 digit phone number';
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

                  if (value.length != 10) {
                    return 'Please enter a 10 digit phone number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                  height: 50,
                  width:50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow),
                      onPressed: () {},
                      child: Text("Create"))),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Log in",
                  style: TextStyle(color: Color(0xFFF15900), fontSize: 28),
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
