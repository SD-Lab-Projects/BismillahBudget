import 'package:bismillahbudget/Widgets/category_dropdown.dart';
import 'package:flutter/material.dart';

class AddTransactionsForm extends StatefulWidget {
  const AddTransactionsForm({super.key});

  @override
  State<AddTransactionsForm> createState() => _AddTransactionsFormState();
}

class _AddTransactionsFormState extends State<AddTransactionsForm> {
  var type ='credit';
  var category ="Others";
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title'
            ),
          ),
          TextFormField(
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

          })
        ],
      ),
    );
  }
}
