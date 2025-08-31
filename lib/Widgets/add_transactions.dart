/*
import 'package:bismillahbudget/Widgets/category_dropdown.dart';
import 'package:bismillahbudget/utility/Appvalidator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

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
  var amountEditController = TextEditingController();
  var titleEditController = TextEditingController();
  var uid = Uuid();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      final user = FirebaseAuth.instance.currentUser;
      int timestamp = DateTime.now().microsecondsSinceEpoch;
      var amount = int.parse( amountEditController.text);
      DateTime date = DateTime.now();

      var id = uid.v4();
      String monthyear = DateFormat('MM y').format(date);

      final userDoc=await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      int remainingAmount = userDoc['remainingAmount'];
      int totalCredit = userDoc['totalCredit'];
      int totalDebit = userDoc['totalDebit'];

      if(type =='credit'){
        remainingAmount+=amount;
        totalCredit+=amount;
      }else{
        remainingAmount-=amount;
        totalDebit+=amount;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
            "remainingAmount": remainingAmount,
            "totalCredit": totalCredit,
            "totalDebit": totalDebit,
            "updateAt": timestamp,
      });

      var data = {
        "id":id,
        "title":titleEditController.text,
        "amount":amount,
        "type":type,
        "timestamp":timestamp,
        "totalCredit":totalCredit,
        "totalDedit":totalDebit,
        "remainingAmount": remainingAmount,
        "monthyear":monthyear,
        "category":category,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection("transactions")
          .doc(id)
          .set(data);

      Navigator.pop(context);

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
              controller: titleEditController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: appValidator.isEmptyCheck,
              decoration: InputDecoration(
                labelText: 'Title'
              ),
            ),
            TextFormField(
              controller: amountEditController,
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
*/
import 'package:bismillahbudget/Widgets/category_dropdown.dart';
import 'package:bismillahbudget/utility/Appvalidator.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../Services/db.dart';

class AddTransactionsForm extends StatefulWidget {
  const AddTransactionsForm({super.key});

  @override
  State<AddTransactionsForm> createState() => _AddTransactionsFormState();
}

class _AddTransactionsFormState extends State<AddTransactionsForm> {
  final _formKey = GlobalKey<FormState>();
  final appValidator = AppValidator();
  final amountEditController = TextEditingController();
  final titleEditController = TextEditingController();
  final uid = Uuid();
  String type = 'credit';
  String category = 'General';
  bool isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoader = true);

      final db = Db();
      final userId = await db.getCurrentUserId();
      if (userId == null) {
        setState(() => isLoader = false);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No active user. Please log in.')),
        );
        return;
      }

      final amount = int.parse(amountEditController.text);
      final date = DateTime.now();
      final id = uid.v4();
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final monthyear = DateFormat('MM y').format(date);

      // Get + update user totals
      final totals = await db.getUserTotals(userId);
      var remainingAmount = totals['remainingAmount']!;
      var totalCredit = totals['totalCredit']!;
      var totalDebit = totals['totalDebit']!;

      if (type == 'credit') {
        totalCredit += amount;
        remainingAmount += amount;
      } else {
        totalDebit += amount;
        remainingAmount -= amount;
      }

      await db.updateUserTotals(
        userId: userId,
        remainingAmount: remainingAmount,
        totalCredit: totalCredit,
        totalDebit: totalDebit,
      );

      // Insert transaction row
      final data = {
        'id': id,
        'user_id': userId,
        'title': titleEditController.text,
        'amount': amount,
        'type': type,
        'timestamp': timestamp,
        'totalCredit': totalCredit,
        'totalDebit': totalDebit,
        'remainingAmount': remainingAmount,
        'monthyear': monthyear,
        'category': category,
      };
      await db.addTransaction(data);

      if (!mounted) return;
      Navigator.pop(context);
      setState(() => isLoader = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleEditController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                return null;
              },

            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: amountEditController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                return null;
              },

            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: type,
                    items: const [
                      DropdownMenuItem(value: 'credit', child: Text('Credit')),
                      DropdownMenuItem(value: 'debit', child: Text('Debit')),
                    ],
                    onChanged: (v) => setState(() => type = v ?? 'credit'),
                    decoration: const InputDecoration(labelText: 'Type'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CategoryDropdown(
                    // pass through if your widget supports it (optional)
                    // cattype: type,
                    onChanged: (val) => setState(() => category = val ?? 'General'),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoader ? null : _submitForm,
              child: isLoader
                  ? const SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
