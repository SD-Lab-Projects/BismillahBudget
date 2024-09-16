
import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  const HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help & Support",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search FAQ...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),

            // FAQ list
            Expanded(
              child: ListView(
                children: [
                  FAQItem(
                    question: 'How to change Username?',
                    answer: 'Not available.',
                  ),
                  FAQItem(
                    question: 'How to change password?',
                    answer: 'Not available',
                  ),
                  FAQItem(
                    question: 'How to change email?',
                    answer: 'Not available',
                  ),
                  FAQItem(
                    question: 'Contact Developers',
                    answer: 'ashfaq.cse.2022020002@aust.edu',
                  ),
                  FAQItem(
                    question: 'Total Balance is not matching credit-debit',
                    answer: 'Please restart the application, if not solved contact support',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// A custom widget for FAQ items
class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    required this.question,
    required this.answer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          question,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              answer,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}

