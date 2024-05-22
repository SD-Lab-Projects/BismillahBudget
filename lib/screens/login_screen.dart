import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//ignore_for_file:prefer_const_constructors

class LoginView extends StatelessWidget{
  LoginView({super.key});

  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();

  Future<void>_submitForm() async{
    if(_formKey.currentstate!.validate()){
      scaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('form submitted successfully')),
      );
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: color(0xFF252634),
    body:singleChildScrollView(
    child:Padding(
    padding:const EdgeInsets.all(16.0),
    child:Form(
    Key:_formKey,
    child:column(
    children: [
    SizedBox(
    height:80.0,
    ),//SizedBox
    width:250,
    child: Text(
    "Login Account",
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white,
    fontSize:28,
        fontWeight: FontWeight.bold), // TextStyle
    ), // Text
    ), // SizedBox

        SizedBox(
          height: 16.0,
        ), // SizedBox
        TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
                color: Color.White,
            ), // TextStyle
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: _buildInputDecoration("Email", Icons.email),
            validator: appValidator.validateEmail), // TextFormField
      SizedBox(
        height: 16.0,
      ), // SizedBox
      TextFormField(
          style: TextStyle(
              color: Colors.white,
          ),//TextStyle
        keyboardType: TextInputType.phone,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: _buildInputDecoration("Password", Icons.lock),
        validator: appValidator.validatePassword,
      ), // TextFormField
      SizedBox(
        height: 40.0,
      ), // SizedBox
      SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:  Color(0xFFF15900)),
              onPressed: _submitForm,
              child: Text("Create",
                  style: TextStyle(fontSize:20)))), // Text

SizedBox(
      height: 30.0,
    ), // SizedBox
        TextButton(
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRouter(builder:(context)=> signUpView()),
              );
            },
            child: Text(
              "Create new account",
              style:
              TextStyle(color: color(0xFFF15900),fontSize: 20),
              ), // Text
            ) // TextButton
         ],
        )), // Column // Form
    ), // Padding
    )); // SingleChildScrollView // Scaffold
  }
    Color (0xFFF15900)),

    SizedBox(

    Color(0xFFF15900), fontSize: 20),

    InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
    fillColor:

    Color(0xAA494A59)