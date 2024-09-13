
import 'package:bismillahbudget/screens/About.dart';
import 'package:bismillahbudget/screens/helpsupportPage.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true; // State for notification switch
  bool _darkModeEnabled = false; // State for appearance switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings",
          style: TextStyle(
              color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Notification setting
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                "Notifications",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            Divider(),

            // Appearance setting
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text(
                "Appearance",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Switch(
                value: _darkModeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
              ),
            ),
            Divider(),

            // Help and Support setting
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                "Help & Support",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpAndSupportPage(),
                  ),
                );
              },
            ),
            Divider(),

            // About setting
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}




