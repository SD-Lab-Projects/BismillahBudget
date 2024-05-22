
import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:flutter/material.dart';

class SignUp_view extends StatelessWidget {
  const SignUp_view({super.key});
  
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();

  //get child => null;
  
  Future<void>_submitForm() async{
    if(_formKey.currentState!.validate()){
      ScaffoldMessenger.of(_formKey.currentState! as BuildContext).showSnackBar(
        const SnackBar(content: Text('Form Submitted successfully'))
      );
    }
  }



  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50.0,

              ),

              SizedBox(
                width: 250,


                   child: Text(
                      "Create new account",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold),
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
                decoration: _buildInputDecoration("Username",Icons.person),
                validator: (value) {
                  if(value!.isEmpty){
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Email",Icons.email),
                validator: _validateEmail,

                    ),


              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration("Phone",Icons.call),
                  validator: _validatePhoneNumber,
              ),

              SizedBox(
                height: 16.0,
              ),

               TextFormField(
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                   decoration: _buildInputDecoration("Password",Icons.lock),
                    validator: _validatPassword,
               ),
                 SizedBox(
                   height: 40.0,
                 ),

                 SizedBox(
                  height: 50,
                  width: double.infinity,
                  child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                      onPressed: () {}, child: Text("Create"))),
                  SizedBox(
                    height: 20.0,
                    
                  ),
                Text(
                  "Log in",
                  style:
                  TextStyle(color: Color(0xFFF15900),fontStyle: 20),
                ),
              


            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        labelText: label,
        suffixIcon: Icon(suffixIcon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))

    );
  }
}






