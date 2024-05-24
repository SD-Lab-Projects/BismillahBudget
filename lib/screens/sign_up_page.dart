
import 'package:bismillahbudget/screens/login_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Services/auth_serices.dart';
import '../utility/Appvalidator.dart';

class SignUpViewPage extends StatefulWidget {
  SignUpViewPage({super.key});
  @override
  State<SignUpViewPage> createState() => _SignUpViewPageState();
}

class _SignUpViewPageState extends State<SignUpViewPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  var authService = AuthServices();
  var isLoader = false;

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "phone": _phoneController.text,
        "password": _passwordController.text,
      };

      await authService.createUser(data, context);
      setState(() {
        isLoader = false;
      });
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
                controller: _userNameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Username", Icons.person),
                validator: AppValidator.validateUsername,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Email", Icons.email),
                validator: AppValidator.validateEmail,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Phone", Icons.call),
                validator: AppValidator.validatePhone,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.white),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Password", Icons.lock),
                validator: AppValidator.validatePassword,
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
                        isLoader ? print("Loading") : _submitForm(context);
                      },
                      child: isLoader
                          ? Center(child: CircularProgressIndicator())
                          : Text(
                        "Create",
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ))),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: () {
                  Get.to(LoginViewPage());
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