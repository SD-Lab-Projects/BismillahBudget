import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  var isLogoutLoading = false;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;

  logout() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    // Get.to(LoginViewPage());
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));

    setState(() {
      // isLogoutLoading = true;
      isLogoutLoading = false;
    });
  }

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    // Get.to(LoginViewPage());
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));

    setState(() {
      // isLogoutLoading = true;
      isLogoutLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  logOut();
                },
                icon: isLogoutLoading
                    ? CircularProgressIndicator()
                    : Icon(Icons.exit_to_app))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          color: Colors.blue.shade900,
          child: Column(
            children: [
              HeroCard(),
            ],
          ),
        ));
  }
}

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
                "58500taka",
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    height: 1.2,
                    fontWeight: FontWeight.w600),
              ),
            ],
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
                ),
                SizedBox(
                  width: 10,
                ),
                CardOne(
                  color: Colors.red,
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
  });

  final Color color;

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
                    "Credit",
                    style: TextStyle(color: color, fontSize: 14),
                  ),
                  Text(
                    "58500taka",
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
                  Icons.arrow_upward_outlined,
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
