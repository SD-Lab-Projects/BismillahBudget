import 'package:bismillahbudget/screens/dashboard.dart';
import 'package:bismillahbudget/utility/Appvalidator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var appValidator = AppValidator();

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully')),
      );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                  width: 250,
                  child: Text(
                    "Login Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Email", Icons.email),
                  //validator: appValidator.validateEmail,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Password", Icons.lock),
                  //validator: appValidator.validatePassword,
                ),
                SizedBox(height: 40.0),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF15900),
                    ),
                    onPressed: () {
                      Get.to(DashBoard());
                    },
                    child: Text("Login", style: TextStyle(fontSize: 20)),
                  ),
                ),
                SizedBox(height: 30.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                  child: Text(
                    "Create new account",
                    style: TextStyle(color: Color(0xFFF15900), fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Color(0xAA494A59),
      labelText: label,
      suffixIcon: Icon(suffixIcon, color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }
}

class SignUpView extends StatelessWidget {
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
          key: GlobalKey<FormState>(),
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
                        if (Form.of(context)!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Form submitted successfully')),
                          );
                        }
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
      labelText: label,
      suffixIcon: Icon(suffixIcon, color: Color(0xFF949494)),
      labelStyle: TextStyle(color: Color(0xFF949494)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x35949494)),
      ),
      filled: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
