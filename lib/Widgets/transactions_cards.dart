/*
import 'package:bismillahbudget/Widgets/transaction_card.dart';
import 'package:bismillahbudget/utility/icons_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsCard extends StatelessWidget {
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
}

class RecentTransactionsList extends StatelessWidget {
  RecentTransactionsList({
    super.key,
  });

  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection("transactions")
            .orderBy('timestamp', descending: true)
            .limit(20)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No transactions found'));
          }

          var data = snapshot.data!.docs;

          return ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var carddata = data[index];
                return TransactionCard(
                  data: carddata,
                );
              });
        });
  }
}
*/
import 'package:flutter/material.dart';
import '../Services/db.dart';
import 'transaction_list.dart';

class TransactionsCard extends StatefulWidget {
  const TransactionsCard({super.key});

  @override
  State<TransactionsCard> createState() => _TransactionsCardState();
}

class _TransactionsCardState extends State<TransactionsCard> {
  late Future<int?> _userIdF;

  @override
  void initState() {
    super.initState();
    _userIdF = Db().getCurrentUserId();
  }

  Future<List<Map<String, dynamic>>> _loadTx(int uid) {
    // You can adjust limit/offset if you want pagination
    return Db().getTransactionsForUser(uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: _userIdF,
      builder: (context, userSnap) {
        if (userSnap.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final uid = userSnap.data;
        if (uid == null) {
          return const SizedBox.shrink();
        }

        return FutureBuilder<List<Map<String, dynamic>>>(
          future: _loadTx(uid),
          builder: (context, txSnap) {
            if (txSnap.connectionState != ConnectionState.done) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final rows = txSnap.data ?? const [];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 1.5,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        'Recent Transactions',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: () => setState(() {}),
                        tooltip: 'Refresh',
                      ),
                    ),
                    const Divider(height: 0),
                    if (rows.isEmpty)
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                        child: Text(
                          'No transactions yet. Tap + to add one.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      TransactionList(transactions: rows),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
