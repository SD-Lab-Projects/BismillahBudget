import 'package:flutter/cupertino.dart';
import 'package:flutter/materlal.dart';

class TranSactionsCard extends StatelessWidget {
  const TranSactionsCard

  (

  {

  super.key
}

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Column(
      children: [
    Row(
    children: [
    Text(
    "Recent Transactions",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    ) // Text
    ],
  ), // Row
  ListView.builder(
  shrinkWrap: true,
  itemCount: 4,
  physics: NeverScrollableScrollPhysics(),
  itemBuilder: (context, index) {
  return padding(
  padding: const EdgeInsets.symmetric(vertical: 10),
  child: Container(
  decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
  BoxShadow(
  offset: Offset(0, 10),
  Colors.grey.withOpacity(0.09),
  blurRadius: 10.0,
  spreadRadius: 4.0) // BoxShadow
  ]), // BoxDecoration
  child: ListTile(
  title: Row(
  Children: [
  Expanded(child: Text("Car Rent Oct 2024"),
  ]
  Text(
  "৳ 8000",
  style:TextStyle(color: Colors.green),
  ) // Text
  ],
  ),//Row
  subtitle:Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children:
  Row(children: [
  Text("Balance", style: TextStyle(color: Colors.grey, fontSize: 13)),
  Spacer(),
  Text("৳ 525", style: TextStyle(color:Colors.grey, fontSize: 13))
  ],), // Row

  Text("25 oct 4:51 PM", style: TextStyle(color: Color.grey),)
  ])//Row

  ]), // Column
  );//listTile
  })//ListView.builder


  @override
  Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
  }]
  ,
  )
  , // column
  )
  , //padding
}}