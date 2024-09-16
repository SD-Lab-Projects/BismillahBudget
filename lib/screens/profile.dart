//profile page is not finished so its not implemented onto the main code
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Menu",
          style: TextStyle(
              color: Colors.white),),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[300],
            ),
            SizedBox(height: 16),


            Text(
              'Ashfaq Durjoy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),


            Text(
              'ashfaq.cse.20220204002@aust.edu',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),


            Text(
              'Account Status: Active', // it was supposed to be dynamic status, which would show if the account is used regularly
              style: TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

