import 'package:bismillahbudget/Widgets/category_dropdown.dart';
import 'package:bismillahbudget/utility/Appvalidator.dart';
import 'package:flutter/material.dart';

class AddTransactionsForm extends StatefulWidget {
  const AddTransactionsForm({super.key});

  @override
  State<AddTransactionsForm> createState() => _AddTransactionsFormState();
}

class _AddTransactionsFormState extends State<AddTransactionsForm> {
  var type ='credit';
  var category ="Others";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var isLoader=false;
  var appValidator = AppValidator();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      setState(() {
        isLoader = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(
                labelText: 'Title'
              ),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            CategoryDropdown(
              cattype: category,
              onChanged: (String? value){
                if(value!=null)
                  {
                    setState(() {
                      category=value;
                    });
                  }
              }
            ),
            DropdownButtonFormField(
                value: 'credit',
                items: [
              DropdownMenuItem(child: Text('Credit'), value: 'credit'),
              DropdownMenuItem(child: Text('Debit'), value: 'debit')
            ], onChanged: (value){
                  if(value!=null){
                    setState(() {
                      type=value;
                    });
                  }
      
            }),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: (){
              if(isLoader==false){
                _submitForm();
              }
            },
                child:
                isLoader ? Center(child: CircularProgressIndicator()):
                Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}
