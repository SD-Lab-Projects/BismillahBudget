import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLineMonth extends StatefulWidget {
  const TimeLineMonth({super.key, required this.onChanged});

  final ValueChanged<String> onChanged; // Use String type for month

  @override
  State<TimeLineMonth> createState() => _TimeLineMonthState();
}

class _TimeLineMonthState extends State<TimeLineMonth> {
  String currentMonth = "";
  final List<String> months = [];
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    for (int i = -18; i <= 0; i++) {
      months.add(DateFormat('MMM y').format(DateTime(now.year, now.month + i, 1)));
    }
    currentMonth = DateFormat('MMM y').format(now);

    Future.delayed(const Duration(seconds: 1), () { // Use 'const' for clarity
      scrollToSelectedMonth();
    });
  }

  void scrollToSelectedMonth() {
    final selectedMonthIndex = months.indexOf(currentMonth);
    if (selectedMonthIndex != -1) {
      final scrollOffset = (selectedMonthIndex * 100.0) - 170;
      scrollController.animateTo(
        scrollOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        controller: scrollController,
        itemCount: months.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentMonth = months[index];
                widget.onChanged(months[index]); // Pass String month
              });
              scrollToSelectedMonth();
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.all(8.0), // Use 'const' for efficiency
              decoration: BoxDecoration(
                color: currentMonth == months[index]
                    ? Colors.blue.shade900
                    : Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  months[index],
                  style: TextStyle(
                    color: currentMonth == months[index]
                        ? Colors.white
                        : Colors.purple,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
