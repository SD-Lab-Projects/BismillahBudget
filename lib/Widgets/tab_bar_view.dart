/*
import 'package:bismillahbudget/Widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TypeBar extends StatelessWidget {
  const TypeBar({super.key, required this.category, required this.monthYear});
  final String category;
  final String monthYear;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(tabs: [
                  Tab(
                    text: 'Credit',
                  ),
                  Tab(
                    text: 'Debit',
                  ),
                ]),
                Expanded(
                    child: TabBarView(
                  children: [
                    TransactionDataList(
                      category: category,
                      type: 'Credit',
                      monthYear: monthYear,
                    ),
                    TransactionDataList(
                      category: category,
                      type: 'Credit',
                      monthYear: monthYear,
                    ),
                  ],
                )
                )
              ],
            )
        )
    );
  }
}
*/
import 'package:bismillahbudget/Services/db.dart';
import 'package:bismillahbudget/Widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class TransactionDataList extends StatelessWidget {
  final String type; // 'credit' or 'debit'
  const TransactionDataList({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: Db().getCurrentUserId(),
      builder: (context, uidSnap) {
        if (uidSnap.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final uid = uidSnap.data;
        if (uid == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder<List<Map<String, dynamic>>>(
          future: Db().getTransactionsForUser(uid),
          builder: (context, txSnap) {
            if (txSnap.connectionState != ConnectionState.done) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final all = txSnap.data ?? const [];
            final filtered = all.where((e) => (e['type'] ?? '') == type).toList();
            if (filtered.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Text('No transactions to show', style: TextStyle(color: Colors.grey)),
              );
            }
            return TransactionList(transactions: filtered);
          },
        );
      },
    );
  }
}
