import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeBar extends StatelessWidget {
  const TypeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultTabController(length: 2, child: Column(children: [
          TabBar(tabs: [
            Tab(text: 'Credit',),
            Tab(text: 'Debit',),
          ]),
          Expanded(
              child: TabBarView(children: [
                Center(
                  child: Text("Credit"),
                ),
                Center(
                  child: Text("Debit"),
                )
              ],))
        ],)));
  }
}
