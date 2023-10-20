import 'package:assignment/pages/favourite_page.dart';
import 'package:assignment/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainePage extends StatefulWidget {
  const MainePage({super.key});

  @override
  State<MainePage> createState() => _MainePageState();
}

class _MainePageState extends State<MainePage> {
  int _currentSelectedIndex = 0;

  final _pages = [
    HomePage(),
    FavouratePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        onTap: (newValue) {
          setState(() {
            _currentSelectedIndex = newValue;
          });
        },
        selectedFontSize: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
        ],
      ),
      body: _pages[_currentSelectedIndex],
    );
  }
}
