import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../utility/icons_list.dart'; // Assuming this is correctly imported

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    String formattedDate = DateFormat('d MMM hh:mm a').format(date);

    // Determine the icon based on data['category'] (this part needs your logic)
    IconData iconData = Icons.category; // Replace with your actual logic
    Color iconColor = data['type'] == 'credit' ? Colors.red : Colors.green;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              color: Colors.grey.withOpacity(0.09),
              blurRadius: 10.0,
              spreadRadius: 4.0,
            ),
          ],
        ),
        child: ListTile(
          minVerticalPadding: 10,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          leading: Container(
            width: 70,
            height: 100,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: data['type'] == 'credit'
                    ? Colors.red.withOpacity(0.2)
                    : Colors.green.withOpacity(0.2),
              ),
              child: Center(
                child: FaIcon(
                  iconData,
                  color: iconColor,
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(child: Text("${data['title']}")),
              Text(
                "${data['type'] == 'credit' ? '+' : '-'}৳ ${data['amount']}",
                style: TextStyle(
                  color: data['type'] == 'credit' ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Balance", style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Spacer(),
                  Text("৳ ${data["remainingAmount"]}", style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
              Text(formattedDate, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
