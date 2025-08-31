import 'package:bismillahbudget/screens/About.dart';
import 'package:bismillahbudget/screens/helpsupportPage.dart';
import 'package:bismillahbudget/Services/auth_serices.dart';
import 'package:bismillahbudget/screens/login_page.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text("Help & Support", style: TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpAndSupportPage()),
                );
              },
            ),
            const Divider(),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About", style: TextStyle(fontSize: 18)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            const Divider(),

            const Spacer(),


            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              onTap: () async {
                await authService.logout(context);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginViewPage()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
