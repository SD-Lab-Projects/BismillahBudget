/*
import 'package:bismillahbudget/Widgets/add_transactions.dart';
import 'package:bismillahbudget/Widgets/transactions_cards.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Widgets/herocard.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginViewPage()));

    setState(() {
      isLogoutLoading = false;
    });
  }
  final userId = FirebaseAuth.instance.currentUser!.uid;
  _dialoBuilder(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        content: AddTransactionsForm(),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed:((){
          _dialoBuilder(context);
        }),
      child: Icon(Icons.add,color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900 ,
        actions: [
          IconButton(
              onPressed: () {
                logOut();
              },
              icon: isLogoutLoading
                  ? Center(child: CircularProgressIndicator())
                  : Icon(Icons.exit_to_app, color: Colors.white,))
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(userId: userId,),
            TransactionsCard(),
          ],
        ),
      ),
    );
  }
}
*/
import 'package:bismillahbudget/Widgets/add_transactions.dart';
import 'package:bismillahbudget/Widgets/transactions_cards.dart';
import 'package:flutter/material.dart';
import '../Widgets/herocard.dart';
import '../Services/db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final id = await Db().getCurrentUserId();
    setState(() => userId = id);
  }

  void _openAddTransaction() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const Padding(
        padding: EdgeInsets.only(bottom: 16.0),
        child: AddTransactionsForm(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bismillah Budget"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTransaction,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (userId != null) HeroCard(userId: userId),
            const TransactionsCard(),
          ],
        ),
      ),
    );
  }
}
