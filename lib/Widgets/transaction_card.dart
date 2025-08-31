/*
import 'package:bismillahbudget/Widgets/transactions_cards.dart';
import 'package:bismillahbudget/utility/icons_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

/*class TransactionsCard extends StatelessWidget {
  TransactionsCard({super.key});

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
              ),
            ],
          ),
          RecentTransactionsList(),
        ],
      ),
    );
  }
}*/

class TransactionCard extends StatelessWidget {
  TransactionCard({
    super.key,
    required this.data,
  });

  final dynamic data;
  var appIcons = AppIcons();

  @override
  Widget build(BuildContext context) {
    DateTime date= DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    // DateTime date = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    String formatedDate = DateFormat(' d MMM hh.mma').format(date);

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
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
              ),
              child: Center(
                child: FaIcon(
                    appIcons.getExpenseCategoryIcons('${data['category']}'),
                    color:
                        data['type'] == 'credit' ? Colors.green : Colors.red),
              ),
            ),
          ),
          title: Row(
            children: [
              Expanded(child: Text('${data['title']}')),
              Text(
                "${data['type'] == 'credit' ? '+' : '-'}৳${data['amount']}",
                style: TextStyle(
                    color:
                        data['type'] == 'credit' ? Colors.green : Colors.red),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Balance",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Spacer(),
                  Text("৳ ${data['remainingAmount']}",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
              Text(formatedDate, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Map<String, dynamic> tx;
  const TransactionCard({super.key, required this.tx});

  @override
  Widget build(BuildContext context) {
    final String title = (tx['title'] ?? '') as String;
    final int amount = (tx['amount'] ?? 0) as int;
    final String type = (tx['type'] ?? 'credit') as String; // 'credit' | 'debit'
    final String category = (tx['category'] ?? 'General') as String;
    final int ts = (tx['timestamp'] ?? 0) as int;

    // timestamp saved as microsecondsSinceEpoch in add_transactions.dart
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(ts, isUtc: false);
    final dateStr = DateFormat('dd MMM, hh:mm a').format(dateTime);

    final isCredit = type == 'credit';
    final amountStyle = TextStyle(
      fontWeight: FontWeight.w700,
      color: isCredit ? Colors.green : Colors.red,
    );

    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('$category • $dateStr'),
      trailing: Text(
        (isCredit ? '+ ' : '- ') + amount.toString(),
        style: amountStyle,
      ),
      leading: CircleAvatar(
        backgroundColor: isCredit ? Colors.green.withOpacity(.12) : Colors.red.withOpacity(.12),
        child: Icon(
          isCredit ? Icons.call_received : Icons.call_made,
          color: isCredit ? Colors.green : Colors.red,
        ),
      ),
      dense: false,
      visualDensity: VisualDensity.comfortable,
    );
  }
}
