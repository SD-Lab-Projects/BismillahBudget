import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  Navbar(
      {super.key,
      required this.selectedIndex,
      required this.onDestinationSelected});

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.explore),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.commute),
          label: 'Transaction',
        ),
      ],
    );
  }
}
