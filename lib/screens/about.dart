import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        iconTheme: IconThemeData(
          color: Colors.white, // Change back button color to white
        ),
      ),
      body: Center(
        child: SingleChildScrollView( // Ensures the content fits well in case of smaller screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers the content vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers the content horizontally
            children: [
              Text(
                'Bismillah Budget',
                style: TextStyle(
                  fontSize: 42, // Make the text bigger
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
              SizedBox(height: 16), // Add some space between the title and the paragraph
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding for the paragraph
                child: Text(
                  'A project made for our CSE 2100, Software Development Lab-II.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center, // Center the paragraph text
                ),
              ),
              SizedBox(height: 24), // Add space before the team members section

              // Team members section
              Text(
                'Mohamamd Ashfaq Hossain Bhuiyan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '20220204002',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8), // Space between entries

              Text(
                'Jannatul Nayem',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '20220204007',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8), // Space between entries

              Text(
                'Abdullah Al Muhit',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '20210104105',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

