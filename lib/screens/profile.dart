
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
          mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
          children: [
            // Profile image section
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey[300], // Background color if image fails to load
            ),
            SizedBox(height: 16), // Space between image and username

            // Username
            Text(
              'John Doe', // Replace with actual username
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8), // Space between username and email

            // Email
            Text(
              'johndoe@example.com', // Replace with actual email
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700], // Slightly lighter color for the email
              ),
            ),
            SizedBox(height: 8), // Space between email and account status

            // Account status
            Text(
              'Account Status: Active', // Replace with dynamic status
              style: TextStyle(
                fontSize: 16,
                color: Colors.green, // Green for active, you can change this dynamically for "Inactive"
              ),
            ),
          ],
        ),
      ),
    );
  }
}

