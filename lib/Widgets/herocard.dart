/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  HeroCard({
    super.key,
    required this.userId,
  });
  final String userId;

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> _usersStream =
    FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        var data = snapshot.data!.data() as Map<String, dynamic>;

        return Cards(
          data: data,
        );
      },
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Balance",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.2,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "৳ ${data['remainingAmount']}",
                  style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      height: 1.2,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                CardOne(
                  color: Colors.green,
                  heading: 'Credit',
                  amount: "${data['totalCredit']}",
                ),
                SizedBox(
                  width: 10,
                ),
                CardOne(
                  color: Colors.red,
                  heading: 'Debit',
                  amount: "${data['totalDebit']}",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  const CardOne({
    super.key,
    required this.color,
    required this.heading,
    required this.amount,
  });

  final Color color;
  final String heading;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: TextStyle(color: color, fontSize: 14),
                  ),
                  Text(
                    "৳${amount}",
                    style: TextStyle(
                        color: color,
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  heading == "Credit"
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined,
                  color: color,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import '../Services/db.dart';

class HeroCard extends StatelessWidget {
  final int? userId;
  const HeroCard({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<Map<String, int>>(
      future: Db().getUserTotals(userId!),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final totals = snap.data ??
            const {'remainingAmount': 0, 'totalCredit': 0, 'totalDebit': 0};
        final remaining = totals['remainingAmount'] ?? 0;
        final credit = totals['totalCredit'] ?? 0;
        final debit = totals['totalDebit'] ?? 0;

        return Card(
          margin: const EdgeInsets.all(16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatBox(
                  label: 'Remaining',
                  value: remaining,
                  color: remaining >= 0 ? Colors.teal : Colors.redAccent,
                  icon: Icons.account_balance_wallet_outlined,
                ),
                _StatBox(
                  label: 'Credit',
                  value: credit,
                  color: Colors.green,
                  icon: Icons.trending_up,
                ),
                _StatBox(
                  label: 'Debit',
                  value: debit,
                  color: Colors.red,
                  icon: Icons.trending_down,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  final IconData icon;

  const _StatBox({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 6),
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
