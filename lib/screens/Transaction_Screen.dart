import 'package:budgettracker/widgets/time_iine_month.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Expansive"), // Use 'const' with the constructor to improve pe
        ), // AppBar
        body: Column( // Use 'const' with the constructor to improve performance.dTry
            children: [   //Use 'const' literals as arguments to constructors of '@immut
            TimeLineMonth(),  //Use 'const' with the constructor to improve performan
    onChanged:(String?value) {},
    ),//TimeLineMonth
    CaregoryList(
    onChanged:(String?value) {},
    ),//CategoryList
    ],
    ), // Column
    ); // Scaffold
    }
}



